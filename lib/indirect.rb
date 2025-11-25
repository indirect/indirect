require "indirect/version"

module Indirect
  class Error < StandardError; end

  class Info
    def initialize(**args)
      @args = args
    end

    def method_missing(name)
      @args[name.to_sym]
    end
  end

  def self.info
    Info.new(
      name: "André Arko",
      handle: "@indirect",
      job: "Founder at Spinel Cooperative",
      job_website: "spinel.coop",
      oss: "Member at The Gem Cooperative",
      oss_website: "gem.coop",
      email: "andre@arko.net",
      website: "arko.net",
      blog: "andre.arko.net",
      bluesky: "@indirect.io",
      github: "indirect",
      linkedin: "andrearko",
      mastodon: "fiasco.social/@indirect",
      card: "indirect",
    )
  end

  def self.run
    generate_card unless File.exist?(card_path)
    puts File.read(card_path)
  end

  def self.generate_card
    require "colorize"
    colors = [:cyan, :green, :blue, :magenta].cycle

    title = [info.name, "/".green, info.handle].join(" ")

    job = {
      "Work" => info.job,
      "" => "https://" << info.job_website.send(colors.next),
    }.select{|k,v| v }

    oss = {
      "Open Source" => info.oss,
      "" => "https://" << info.oss_website.send(colors.next),
    }.select{|k,v| v }

    contact = {
      "Email" => info.email ? info.email.send(colors.next) : nil,
      "Website" => info.website ? "https://" << info.website.send(colors.next) : nil,
      "Blog" => info.blog ? "https://" << info.blog.send(colors.next) : nil,
      "GitHub" => info.github ? "https://github.com/" << info.github.send(colors.next) : nil,
      "Mastodon" => info.twitter ? "https://" << info.mastodon.send(colors.next) : nil,
      "Bluesky" => info.bluesky ? "https://bsky.app/profile/" << info.bluesky.send(colors.next) : nil,
      "LinkedIn" => info.linkedin ? "https://linkedin.com/in/" << info.linkedin.send(colors.next) : nil,
    }.select{|k,v| v }

    card = {
      "Card" => info.card ? "gem exec " << info.card.send(colors.next) : nil
    }.select{|k,v| v }

    sections = [job, oss, contact, card]
    label_size = sections.map(&:keys).flatten.map(&:length).max

    body = sections.map do |section|
      section.map do |name, value|
        label = sprintf("%#{label_size}s", name)
        label << (name.empty? ? "  " : ": ")
        [label.white.bold, value].join
      end.join("\n")
    end.join("\n\n")

    content = [title, body].join("\n\n")

    File.write card_path, in_box(content)
  end

  def self.in_box(content)
    require "colorize"
    width = content.lines.map(&:uncolorize).map(&:length).max
    edge_size = width + 6

    box = "╭" << "─" * edge_size << "╮\n"
    box << "│" << " " * edge_size << "│\n"

    title = content.lines.first
    cc = (width - title.chomp.uncolorize.size) / 2
    box << "│   " << " " * cc << title.chomp << " " * cc << "    │\n"

    content.lines[1..-1].each do |line|
      space_count = width - line.chomp.uncolorize.size
      box << "│   " << line.chomp << " " * space_count << "   │\n"
    end

    box << "│" << " " * edge_size << "│\n"
    box << "╰" << "─" * edge_size << "╯"
  end

  def self.card_path
    File.expand_path("output", __dir__)
  end
end
