{
inputs,
...
}:
{
  additions = final: _prev: import ../pkgs final.pkgs;
  modifications = final: prev: {
    intel-vaapi-driver = prev.intel-vaapi-driver.override {
     enableHybridCodec = true;
    };
  };
}
