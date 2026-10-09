cask "moreinfo" do
  version "0.9.1"
  sha256 "00eb9059fe53cc804358d32e1c8b6aaf26e430c723ead12825be263323da78f0"

  url "https://github.com/eafarris/MoreInfo/releases/download/v#{version}/MoreInfo_#{version}_aarch64.dmg"
  name "MoreInfo"
  desc "Markdown-based personal knowledge base with wiki links, journals and tasks"
  homepage "https://github.com/eafarris/MoreInfo"

  livecheck do
    url :url
    strategy :github_latest
  end

  # Only an Apple Silicon build is published.
  depends_on arch: :arm64
  depends_on :macos

  app "MoreInfo.app"

  # The release build is not signed with a Developer ID or notarized, so
  # Gatekeeper would refuse to open the quarantined app. Remove the
  # quarantine flag until notarization is set up.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/MoreInfo.app"]
  end

  # User data in ~/Documents/MoreInfo is intentionally never removed.
  zap trash: [
    "~/Library/Application Support/com.moreinfo.dev",
    "~/Library/Caches/com.moreinfo.dev",
    "~/Library/Caches/MoreInfo",
    "~/Library/HTTPStorages/com.moreinfo.dev*",
    "~/Library/Preferences/com.moreinfo.dev.plist",
    "~/Library/Saved Application State/com.moreinfo.dev.savedState",
    "~/Library/WebKit/com.moreinfo.dev",
    "~/Library/WebKit/MoreInfo",
  ]
end
