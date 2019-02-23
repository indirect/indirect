require "indirect/version"
require "ostruct"

module Indirect
  class Error < StandardError; end

  def self.info
    OpenStruct.new(
      name: "Andre Arko",
      handle: "indirect",
      job: "Vice Minister of Computation at CloudCity.io",
      oss: "Founder at Ruby Together and Team Lead of Bundler",
      email: "andre@arko.net",
      website: "https://arko.net",
      blog: "https://andre.arko.net",
      twitter: "indirect",
      github: "indirect",
      linkedin: "https://www.linkedin.com/in/andrearko",
      card: "indirect",
    )
  end

  def self.run
    generate_card unless File.exist?(card_path)
    puts File.read(card_path)
  end

  def self.generate_card
    require "colorize"
    title = [info.name, "/", info.handle].join(" ")

    work = {
      "Work" => info.job,
      "Open Source" => info.oss,
    }.select{|k,v| v }

    contact = {
      "Email" => info.email,
      "Website" => info.website,
      "Blog" => info.blog,
      "Twitter" => info.twitter,
      "GitHub" => info.github ? "https://github.com/" << info.github.cyan : nil,
      "LinkedIn" => info.linkedin,
    }.select{|k,v| v }

    card = {
      "Card" => info.card ? "npx " << info.card : nil
    }.select{|k,v| v }

    sections = [work, contact, card]
    content = title << "\n\n" << [work, contact, card].map do |section|
      section.map{|line| line.join(": ") }.join("\n")
    end.join("\n\n")

    File.write card_path, content
  end

  def self.card_path
    File.expand_path("output", __dir__)
  end
end
