# Template: the release workflow fills in 0.2.0 and 97ce29fb64e16007244c08f4b3d824c32baa3425eb1f16bfe08c6818871de914 and commits
# the result to github.com/sameera207/homebrew-tap.
class VoiceDraft < Formula
  desc "Private, on-device dictation for macOS (whisper.cpp + Ollama + Hammerspoon)"
  homepage "https://github.com/sameera207/voice-draft"
  url "https://github.com/sameera207/voice-draft/releases/download/v0.2.0/voice-draft-0.2.0.tar.gz"
  sha256 "97ce29fb64e16007244c08f4b3d824c32baa3425eb1f16bfe08c6818871de914"

  depends_on arch: :arm64
  depends_on :macos
  depends_on "sox"
  depends_on "whisper-cpp"

  def install
    libexec.install Dir["*"]
    bin.install_symlink libexec/"bin/voice-draft"
  end

  def caveats
    <<~EOS
      Finish setup (installs Hammerspoon and Ollama if needed, downloads the
      ~1.6 GB Whisper model and links voice-draft into Hammerspoon):
        voice-draft setup

      Optional automatic updates (daily `brew upgrade voice-draft`):
        voice-draft autoupdate on
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/voice-draft version")
  end
end
