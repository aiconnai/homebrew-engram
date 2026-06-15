class Engram < Formula
  desc "Memory for production AI agents - hybrid search, knowledge graphs, MCP protocol"
  homepage "https://github.com/aiconnai/engram"
  version "0.21.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/aiconnai/engram/releases/download/v#{version}/engram-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "6f174f3d06dc1c36477f961cbfb2628d165da5474ea1b7967510b5b8e48e7903"
    else
      url "https://github.com/aiconnai/engram/releases/download/v#{version}/engram-v#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "5f932acb5264fcfc99c6e6139a53da9ba50713e21e2c1cf6376351f23ed76d03"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/aiconnai/engram/releases/download/v#{version}/engram-v#{version}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "a1c80752b11ac4ee7e58f2d56c4add5120d4239b8cee94f82dc3667d346d0046"
    else
      url "https://github.com/aiconnai/engram/releases/download/v#{version}/engram-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "b4f6a8e72b91516798a3b2595ba318d15cc3881e62d88efb06156839771ed70f"
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
