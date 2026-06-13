{ pkgs, lib, config, inputs, ... }:

let
  claudeCodeVersion = "2.1.176";
  claudeCodeBaseUrl = "https://storage.googleapis.com/claude-code-dist-86c565f3-f756-42ad-8dfa-d59b1c096819/claude-code-releases";
  claudeCodeChecksums = {
    "x86_64-linux"   = "075bc326c19a5484c86f3ea8633cf4bf7e26ed72bf3529bc8b64a00db1c488cc";
    "aarch64-linux"  = "95924cc57a03d9b3b58b262aef7f6c8719653c991c82b6b8690c7a5422690d63";
    "x86_64-darwin"  = "68cc0e17ab0b741c87eba77ae097d6da49d335952cdd9ca4c3dc75d9d5496222";
    "aarch64-darwin" = "f3f1b0c098510bd5d472b15f5541bb261f5939aeb52e488760bc53fb54c1803d";
  };
  claudeCodePlatformKey = {
    "x86_64-linux"   = "linux-x64";
    "aarch64-linux"  = "linux-arm64";
    "x86_64-darwin"  = "darwin-x64";
    "aarch64-darwin" = "darwin-arm64";
  }.${pkgs.stdenv.hostPlatform.system};
  claude-code-latest = pkgs.claude-code.overrideAttrs (_: {
    version = claudeCodeVersion;
    src = pkgs.fetchurl {
      url = "${claudeCodeBaseUrl}/${claudeCodeVersion}/${claudeCodePlatformKey}/claude";
      sha256 = claudeCodeChecksums.${pkgs.stdenv.hostPlatform.system};
    };
  });
in

{
  dotenv.enable = true;

  env = {
    # NODE_ENV = "development";
    #NOTE: UNCOMMENT for local development
    # these variables will override their counterpart in .env
    # MINIO_HOST = "localhost";
    # BACKEND_URL = "http://localhost:5000";
    # DEV = "1";
    # DEV_FRONTEND_URL = "http://localhost:3000";
  };
  # https://devenv.sh/languages/
  # languages.nix = {
  #   enable = true;
  #   lsp.package = pkgs.nil;


  # };
  packages = with pkgs; [
    htop
    btop
    claude-code-latest
    dig
    nmap
    dnsutils
    nil
    nixd
    act  # Run GitHub Actions locally (act -l, act push, act -j build-and-verify)
    traceroute
    git-lfs
    gh
    ansible
    rsync
    openssh
    sshpass
    jq
    mkcert  # TLS cert generation for local development (used by dashboard hostname changes)
    # python313Packages.requests
    # poppler-utils
    # tesseract
    # leptonica
    # libGL
    # glib
    # cairo
    # pango
    # harfbuzz
    # freetype
    # fontconfig

  ];

  # # https://devenv.sh/scripts/
  # scripts.finstall.exec = ''
  #   cd frontend && pnpm install
  # '';
  # scripts.fdev.exec = ''
  #   cd frontend && pnpm run dev
  # '';
  # scripts.bdev.exec = ''
  #   cd backend && \
  #       uvicorn main:app \
  #         --reload \
  #         --reload-exclude "__pycache__/*" \
  #         --reload-exclude ".venv/*" \
  #         --reload-exclude "*.pyc" \
  #         --reload-exclude "*.log" \
  #         --reload-exclude ".mypy_cache/*" \
  #         --reload-exclude ".pytest_cache/*" \
  #         --reload-exclude ".ruff_cache/*" \
  #         --reload-exclude ".coverage" \
  #         --log-level debug \
  #         --port 5000
  #
  # '';

}
