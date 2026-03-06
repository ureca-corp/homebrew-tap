class FastapiDomainMonitor < Formula
  desc "Real-time SQLModel domain diagram dashboard for FastAPI projects"
  homepage "https://github.com/ureca-corp/fastapi-domain-monitor"
  url "https://github.com/ureca-corp/fastapi-domain-monitor/archive/refs/tags/v0.1.2.tar.gz"
  sha256 "6b8a6840aa13e3863501efcfdd4eec0888dc181c2d473c9326d249be8ec4b84a"
  license "MIT"
  version "0.1.2"

  depends_on "python@3.12"

  def install
    python3 = Formula["python@3.12"].opt_bin/"python3.12"

    # buildpath(소스 빌드) 대신 PyPI 휠에서 직접 설치
    # buildpath 방식은 hatchling 빌드 백엔드 누락으로 실패할 수 있음
    system python3, "-m", "venv", libexec
    system libexec/"bin/pip", "install", "--no-cache-dir",
           "fastapi-domain-monitor==#{version}"

    bin.install_symlink libexec/"bin/domain-monitor"
  end

  test do
    assert_match "0.1.2", shell_output("#{bin}/domain-monitor --version")
    assert_match "start", shell_output("#{bin}/domain-monitor --help")
  end
end
