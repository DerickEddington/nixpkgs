{ buildGoModule
, fetchFromGitHub
, lib
}:

buildGoModule rec {
  pname = "bazel-remote";
  version = "2.3.5";

  src = fetchFromGitHub {
    owner = "buchgr";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-8tT00ppqBGLw2h+RxaiD7r3XYzyvXOHj1U8V5H/ftyQ=";
  };

  vendorSha256 = "sha256-wXgW7HigMIeUZAcZpm5TH9thfCHmpz+M42toWHgwIYo=";

  doCheck = false;

  meta = with lib; {
    homepage = "https://github.com/buchgr/bazel-remote";
    description = "A remote HTTP/1.1 cache for Bazel";
    license = licenses.asl20;
    maintainers = lib.teams.bazel.members;
    platforms = platforms.darwin ++ platforms.linux;
  };
}
