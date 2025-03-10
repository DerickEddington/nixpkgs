{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "minio-client";
  version = "2022-03-13T22-34-00Z";

  src = fetchFromGitHub {
    owner = "minio";
    repo = "mc";
    rev = "RELEASE.${version}";
    sha256 = "sha256-NIhowfkG2bFIcCNXUQ3cETHsR5/NLvIHQ9LeftgSyd0=";
  };

  vendorSha256 = "sha256-Wdw9mZ3UupoJ4yDwS4f3mOmCn+7TvHmx4aRu+96pHM4=";

  subPackages = [ "." ];

  patchPhase = ''
    sed -i "s/Version.*/Version = \"${version}\"/g" cmd/build-constants.go
    sed -i "s/ReleaseTag.*/ReleaseTag = \"RELEASE.${version}\"/g" cmd/build-constants.go
    sed -i "s/CommitID.*/CommitID = \"${src.rev}\"/g" cmd/build-constants.go
  '';

  doInstallCheck = true;
  installCheckPhase = ''
    $out/bin/mc --version | grep ${version} > /dev/null
  '';

  meta = with lib; {
    homepage = "https://github.com/minio/mc";
    description = "A replacement for ls, cp, mkdir, diff and rsync commands for filesystems and object storage";
    maintainers = with maintainers; [ bachp eelco ];
    platforms = platforms.unix;
    license = licenses.asl20;
  };
}
