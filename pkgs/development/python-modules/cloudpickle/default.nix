{ lib
, buildPythonPackage
, fetchPypi
, psutil
, pytestCheckHook
, pythonOlder
}:

buildPythonPackage rec {
  pname = "cloudpickle";
  version = "2.2.0";
  format = "setuptools";

  disabled = pythonOlder "3.6";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-P0IZRpxVRTz+RzflZLZ8KhSRCdq/fyQkeJSLiV9hEG8=";
  };

  nativeCheckInputs = [
    psutil
    pytestCheckHook
  ];

  pythonImportsCheck = [
    "cloudpickle"
  ];

  disabledTestPaths = [
    # ModuleNotFoundError: No module named '_cloudpickle_testpkg'
    "tests/cloudpickle_test.py"
  ];

  disabledTests = [
    # TypeError: cannot pickle 'EncodedFile' object
    "test_pickling_special_file_handles"
  ];

  meta = with lib; {
    description = "Extended pickling support for Python objects";
    homepage = "https://github.com/cloudpipe/cloudpickle";
    license = with licenses; [ bsd3 ];
    maintainers = with maintainers; [ ];
  };
}
