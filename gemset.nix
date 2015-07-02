{
  "bcrypt" = {
    version = "3.1.10";
    source = {
      type = "gem";
      sha256 = "15cf7zzlj9b0xcx12jf8fmnpc8g1b0yhxal1yr5p7ny3mrz5pll6";
    };
  };
  "haml" = {
    version = "4.0.6";
    source = {
      type = "gem";
      sha256 = "08zzpqij5sxp1yjq7hw7c4f8xc8dxhvdhw7mv9qqxn9q3y55zpif";
    };
    dependencies = [
      "tilt"
    ];
  };
  "rack" = {
    version = "1.5.2";
    source = {
      type = "gem";
      sha256 = "19szfw76cscrzjldvw30jp3461zl00w4xvw1x9lsmyp86h1g0jp6";
    };
  };
  "rack-protection" = {
    version = "1.5.3";
    source = {
      type = "gem";
      sha256 = "0cvb21zz7p9wy23wdav63z5qzfn4nialik22yqp6gihkgfqqrh5r";
    };
    dependencies = [
      "rack"
    ];
  };
  "sequel" = {
    version = "4.19.0";
    source = {
      type = "gem";
      sha256 = "10qyfskhq0p8l7y86v5avnpy811i5pxkgn8y6vrxmyll73qcaflp";
    };
  };
  "sequel_secure_password" = {
    version = "0.2.11";
    source = {
      type = "gem";
      sha256 = "1in0dq955v93mm1vsj7ad3r4dbd807glnwd9jaxa2zmnpmggq9l3";
    };
    dependencies = [
      "bcrypt"
      "sequel"
    ];
  };
  "shotgun" = {
    version = "0.9";
    source = {
      type = "gem";
      sha256 = "19a5a0qi137hckcw1hhvk2wym2l4zdbmi6252f23cjj9z5gjh62m";
    };
    dependencies = [
      "rack"
    ];
  };
  "sinatra" = {
    version = "1.4.5";
    source = {
      type = "gem";
      sha256 = "0qyna3wzlnvsz69d21lxcm3ixq7db08mi08l0a88011qi4qq701s";
    };
    dependencies = [
      "rack"
      "rack-protection"
      "tilt"
    ];
  };
  "sinatra-flash" = {
    version = "0.3.0";
    source = {
      type = "gem";
      sha256 = "1vhpyzv3nvx6rl01pgzg5a9wdarb5iccj73gvk6hv1218gd49w7y";
    };
    dependencies = [
      "sinatra"
    ];
  };
  "sinatra-redirect-with-flash" = {
    version = "0.2.1";
    source = {
      type = "gem";
      sha256 = "0s32xirdcg1zr4q90r5hakamrs5rr21mzaccr0s64vxgmnxn5hdq";
    };
    dependencies = [
      "sinatra"
    ];
  };
  "sqlite3" = {
    version = "1.3.10";
    source = {
      type = "gem";
      sha256 = "1qzg74nrzlwxz0ykxdg4m2bl5vqyh796y8wbnsh315mxhjz1bn3h";
    };
  };
  "tilt" = {
    version = "1.4.1";
    source = {
      type = "gem";
      sha256 = "00sr3yy7sbqaq7cb2d2kpycajxqf1b1wr1yy33z4bnzmqii0b0ir";
    };
  };
}