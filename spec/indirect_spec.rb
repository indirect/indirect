RSpec.describe Indirect do
  it "has a version number" do
    expect(Indirect::VERSION).not_to be nil
  end

  describe "#in_box" do
    it "boxes text" do
      content = "hello"
      expect(Indirect.in_box(content)).to eq(<<-END.chomp
╭───────────╮
│           │
│   hello   │
│           │
╰───────────╯
END
)
    end

    it "centers the top line" do
      content = "hello\n\nthis line is longer"
      expect(Indirect.in_box(content)).to eq(<<-END.chomp
╭─────────────────────────╮
│                         │
│          hello          │
│                         │
│   this line is longer   │
│                         │
╰─────────────────────────╯
END
)
    end
  end

end
