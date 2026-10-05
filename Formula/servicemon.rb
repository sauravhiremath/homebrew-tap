class Servicemon < Formula
  desc "Control local development services with a CLI and dashboard"
  homepage "https://github.com/sauravhiremath/servicemon"
  url "https://github.com/sauravhiremath/servicemon/releases/download/v0.1.1/servicemon-0.1.1-source.tar.gz"
  sha256 "3184eb01cae97fa2c7b40520b3404c8ff8e28dc0d7b73df679dbb9ed1590f07c"
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
                    "LICENSE", "CONTRIBUTING.md", "README.md"
    libexec.install "docs", "examples", "skills"
    (libexec/"scripts").install "scripts/smoke-installed.mjs"
    (bin/"servicemon").write <<~SH
      #!/bin/sh
      export SERVICEMON_STARTUP_EXECUTABLE="#{opt_bin}/servicemon"
      exec "#{formula_opt_bin("node")}/node" "#{opt_libexec}/dist/cli/main.js" "$@"
    SH
  end

  def caveats
    <<~EOS
      Get started
        Create ~/.config/servicemon/config.yaml, then run:
          servicemon serve --background
          servicemon dashboard

      Agent skill (optional)
          npx skills add sauravhiremath/servicemon --skill servicemon --global

      Maintenance
        Use Servicemon commands, not brew services.
        Stop the manager before Servicemon or Node upgrades.
        Before uninstalling: servicemon startup disable; servicemon manager stop

      Guide
        https://github.com/sauravhiremath/servicemon#first-use
    EOS
  end

  test do
    system formula_opt_bin("node")/"node", libexec/"scripts/smoke-installed.mjs", bin/"servicemon"
  end
end
