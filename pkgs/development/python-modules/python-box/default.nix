{ lib
, buildPythonPackage
, fetchFromGitHub
, msgpack
, pytestCheckHook
, pythonOlder
, pyyaml
, ruamel-yaml
, toml
}:

buildPythonPackage rec {
  pname = "python-box";
  version = "6.0.0";
  format = "setuptools";

  disabled = pythonOlder "3.6";

  src = fetchFromGitHub {
    owner = "cdgriffith";
    repo = "Box";
    rev = version;
    hash = "sha256-YOYcI+OAuTumNtTylUc6dSY9shOE6eTr8M3rVbcy5hs=";
  };

  propagatedBuildInputs = [
    msgpack
    pyyaml
    ruamel-yaml
    toml
  ];

  checkInputs = [
    pytestCheckHook
  ];

  pythonImportsCheck = [
    "box"
  ];

  meta = with lib; {
    description = "Python dictionaries with advanced dot notation access";
    homepage = "https://github.com/cdgriffith/Box";
    license = with licenses; [ mit ];
    maintainers = with maintainers; [ fab ];
  };
}
