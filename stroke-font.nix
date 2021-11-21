{ lib
, stdenv
, fetchFromGitHub
, python3
}:

stdenv.mkDerivation {
  pname = "stroke-font";
  version = "0.pre+unstable=2021-10-27";

  src = fetchFromGitHub {
    owner = "Shriinivas";
    repo = "inkscapestrokefont";
    rev = "3ba48997ff06a312ac3ba7008566240ad7e36bf8";
    sha256 = "2csoEHFsYsHtvWCUqHae1POI9QMvlMR/Q9USFb3w/SY=";
  };

  checkInputs = [
    python3.pkgs.inkex
  ];

  dontBuild = true;

  doCheck = true;

  installPhase = ''
    install -Dt "$out/share/inkscape/extensions" *.inx *.py
    cp -r strokefontdata "$out/share/inkscape/extensions"
  '';

  meta = with lib; {
    description = "adsf";
    homepage = "https://github.com/Shriinivas/inkscapestrokefont";
    license = licenses.gpl2Only;
    maintainers = with maintainers; [ mrvandalo ];
    platforms = platforms.all;
  };
}
