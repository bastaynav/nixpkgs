{
  buildPythonPackage,
  fetchFromGitHub,
  lib,
  parver,
  pulumi,
  pythonOlder,
  semver,
  setuptools,
}:

buildPythonPackage rec {
  pname = "pulumi-hcloud";
  version = "1.21.1";

  pyproject = true;
  build-system = [ setuptools ];

  disabled = pythonOlder "3.8";

  src = fetchFromGitHub {
    owner = "pulumi";
    repo = "pulumi-hcloud";
    tag = "v${version}";
    hash = "sha256-waeA+qYLj4WFUgNK5/54gfRQivNiIvIp6FoxgpeRjlM=";
  };

  sourceRoot = "${src.name}/sdk/python";

  # The upstream repository does not contain tests
  doCheck = false;

  dependencies = [
    parver
    pulumi
    semver
  ];

  pythonImportsCheck = [ "pulumi_hcloud" ];

  meta = with lib; {
    description = "Pulumi python hetzner web services provider";
    homepage = "https://github.com/pulumi/pulumi-hcloud";
    changelog = "https://github.com/pulumi/pulumi-hcloud/releases/tag/${src.tag}";
    license = licenses.asl20;
    maintainers = with maintainers; [ albertodvp ];
  };
}
