class Engram < Formula
  desc "Memory for production AI agents - hybrid search, knowledge graphs, MCP protocol"
  homepage "https://github.com/aiconnai/engram"
  version "0.21.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/aiconnai/engram/releases/download/v#{version}/engram-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "0c1ac606c4644bafcea8efcd59e82c1dc468717977a41ee58d1d14f4a74dc770"
    else
      url "https://github.com/aiconnai/engram/releases/download/v#{version}/engram-v#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "7a243381467d6c882abd12c7f2ccc7a9c7964a3616321189494478568e5474ea"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/aiconnai/engram/releases/download/v#{version}/engram-v#{version}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "9203c3b4fd4bc5b0abb374b0051a96ce31e085147e9547b8dc10f4fc6201b74a"
    else
      url "https://github.com/aiconnai/engram/releases/download/v#{version}/engram-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "cb24d18342f053b232476030bbdc25f71ce729a2f92b7cfd3ef2928b2ec39c70"
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
