require "indirect/version"
require "ostruct"

module Indirect
  class Error < StandardError; end

  def self.info
    OpenStruct.new(
      name: "André Arko",
      handle: "indirect",
      job: "Vice Minister of Computation at CloudCity.io",
      oss: "Founder at Ruby Together and Team Lead of Bundler",
      email: "andre@arko.net",
      website: "arko.net",
      blog: "andre.arko.net",
      twitter: "indirect",
      github: "indirect",
      linkedin: "andrearko",
      card: "indirect",
    )
  end

  def self.run
    generate_card unless File.exist?(card_path)
    puts File.read(card_path)
  end

  def self.generate_card
    require "colorize"
    colors = [:cyan, :red, :blue, :green].cycle

    title = [info.name.white, "/".green, info.handle.white].join(" ")

    work = {
      "Work" => info.job.white,
      "Open Source" => info.oss.white,
    }.select{|k,v| v }

    contact = {
      "Email" => info.email ? info.email.send(colors.next) : nil,
      "Website" => info.website ? "https://" << info.website.send(colors.next) : nil,
      "Blog" => info.blog ? "https://" << info.blog.send(colors.next) : nil,
      "Twitter" => info.twitter ? "https://" << info.twitter.send(colors.next) : nil,
      "GitHub" => info.github ? "https://github.com/" << info.github.send(colors.next) : nil,
      "LinkedIn" => info.linkedin ? "https://linkedin.com/in/" << info.linkedin.send(colors.next) : nil,
    }.select{|k,v| v }

    card = {
      "Card" => info.card ? "gemx ".red << info.card.white : nil
    }.select{|k,v| v }

    sections = [work, contact, card]

    body = sections.map do |section|
      section.map{|name, value| (name + ": ").white.bold << value }.join("\n")
    end.join("\n\n")

    content = [title, body].join("\n\n")

    File.write card_path, content
  end

  def self.card_path
    File.expand_path("output", __dir__)
  end
end
