# Template: the release workflow fills in 0.4.0 and e9a0ac5d740c3c5176b9cb999678bb04f4318bb60746ab7dc26843eddf9bb77a and commits
# the result to github.com/sameera207/homebrew-tap.
class VoiceDraft < Formula
  desc "Private, on-device dictation for macOS (whisper.cpp + Ollama + Hammerspoon)"
  homepage "https://github.com/sameera207/voice-draft"
  url "https://github.com/sameera207/voice-draft/releases/download/v0.4.0/voice-draft-0.4.0.tar.gz"
  sha256 "e9a0ac5d740c3c5176b9cb999678bb04f4318bb60746ab7dc26843eddf9bb77a"

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
