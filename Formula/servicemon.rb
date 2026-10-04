class Servicemon < Formula
  desc "Control local development services with a CLI and dashboard"
  homepage "https://github.com/sauravhiremath/servicemon"
  url "https://github.com/sauravhiremath/servicemon/releases/download/v0.1.0/servicemon-0.1.0-source.tar.gz"
  sha256 "42d447e543469bcee233db017f594e7fe5bff44ee08835806bb2c0a3f2c32ca0"
  license "MIT"

  depends_on :macos
  depends_on "node"

  def fetch
    ENV.prepend_path "PATH", formula_opt_bin("node")
    ENV["npm_config_cache"] = HOMEBREW_CACHE/"npm_cache"
    system "npm", "ci", "--ignore-scripts", "--no-audit", "--no-fund"
  end

  def install
    ENV.prepend_path "PATH", formula_opt_bin("node")
    ENV["npm_config_cache"] = HOMEBREW_CACHE/"npm_cache"
    system "npm", "ci", "--offline", "--ignore-scripts", "--no-audit", "--no-fund"
    system "npm", "run", "build"
    system "node", "scripts/release-check.mjs", "--tag", "v#{version}"
    system "npm", "prune", "--offline", "--omit=dev", "--ignore-scripts", "--no-audit", "--no-fund"
    system "node", "scripts/release-check.mjs", "--runtime"
    libexec.install "dist", "node_modules", "package.json", "package-lock.json",
                    "LICENSE", "CONTRIBUTING.md", "README.md", "CHANGELOG.md"
    libexec.install "docs", "examples"
    (libexec/"scripts").install "scripts/smoke-installed.mjs"
    (bin/"servicemon").write <<~SH
      #!/bin/sh
      export SERVICEMON_STARTUP_EXECUTABLE="#{opt_bin}/servicemon"
      exec "#{formula_opt_bin("node")}/node" "#{opt_libexec}/dist/cli/main.js" "$@"
    SH
  end

  def caveats
    <<~EOS
      Create ~/.config/servicemon/config.yaml before first use.
      Start explicitly: servicemon serve --background
      Open the dashboard: servicemon dashboard
      Login startup is optional: servicemon startup enable
      Stop the manager before package or Node upgrades.
      Before removal: servicemon startup disable; servicemon manager stop
      Config, retained logs, and Compose volumes are not package files.
      Do not use brew services. Read the installed operations guide.
    EOS
  end

  test do
    system formula_opt_bin("node")/"node", libexec/"scripts/smoke-installed.mjs", bin/"servicemon"
  end
end
