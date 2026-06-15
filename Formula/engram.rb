class Engram < Formula
  desc "Memory for production AI agents - hybrid search, knowledge graphs, MCP protocol"
  homepage "https://github.com/aiconnai/engram"
  version "0.21.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/aiconnai/engram/releases/download/v#{version}/engram-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "eea30247fe57bb982d3f63a01d5e99344a4560004ec726c44064f7f22ea7f61a"
    else
      url "https://github.com/aiconnai/engram/releases/download/v#{version}/engram-v#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "9f073c90e9e5070ec65e32575bd0cbb465f51d2bf2e1fd06e030bf84a2d87483"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/aiconnai/engram/releases/download/v#{version}/engram-v#{version}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "530c92bcc516d0f18706f83606e6275816a28ddd4d3281c93eec9c18050e8628"
    else
      url "https://github.com/aiconnai/engram/releases/download/v#{version}/engram-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "f81c900dc8c20d8ddd53abf29c68bc85eac71f08b442779b21eed17d60da8510"
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
