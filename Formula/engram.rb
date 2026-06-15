class Engram < Formula
  desc "Memory for production AI agents - hybrid search, knowledge graphs, MCP protocol"
  homepage "https://github.com/aiconnai/engram"
  version "0.21.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/aiconnai/engram/releases/download/v#{version}/engram-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "017842f8a1deaa711c6644eef71c84a3103928f080fef36617b0413b6ea9cdee"
    else
      url "https://github.com/aiconnai/engram/releases/download/v#{version}/engram-v#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "453f5aa97910dee37f275034f23b9769486e73ef364d44c8594cf9fa267a6c7b"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/aiconnai/engram/releases/download/v#{version}/engram-v#{version}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e0a7a166e20966ad0714d7ba07d0ff62fdc05ba8017746160bbc5721a2e6dc90"
    else
      url "https://github.com/aiconnai/engram/releases/download/v#{version}/engram-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e5afc71d2964cf8e121ceabeca9ed6a322907b8f041fc129556e784e9f95609f"
    end
  end

  def install
    bin.install "engram-server"
    bin.install "engram-cli"
  end

  def post_install
    (var/"lib/engram").mkpath
  end

  def caveats
    <<~EOS
      Engram stores its database at:
        ~/.local/share/engram/memories.db

      To use with MCP clients (Claude Code, Cursor, VS Code MCP extensions), add this server config in your MCP settings:
        {
          "mcpServers": {
            "engram": {
              "command": "#{opt_bin}/engram-server",
              "args": [],
              "env": {}
            }
          }
        }
    EOS
  end

  test do
    assert_match "engram", shell_output("#{bin}/engram-cli --version")
  end
end
