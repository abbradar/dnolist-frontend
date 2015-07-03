{
  "domain_name" = {
    version = "0.5.24";
    source = {
      type = "gem";
      sha256 = "1xjm5arwc35wryn0hbfldx2pfhwx5qilkv7yms4kz0jri3m6mgcc";
    };
    dependencies = [
      "unf"
    ];
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
  "http-cookie" = {
    version = "1.0.2";
    source = {
      type = "gem";
      sha256 = "0cz2fdkngs3jc5w32a6xcl511hy03a7zdiy988jk1sf3bf5v3hdw";
    };
    dependencies = [
      "domain_name"
    ];
  };
  "json" = {
    version = "1.8.3";
    source = {
      type = "gem";
      sha256 = "1nsby6ry8l9xg3yw4adlhk2pnc7i0h0rznvcss4vk3v74qg0k8lc";
    };
  };
  "mime-types" = {
    version = "2.6.1";
    source = {
      type = "gem";
      sha256 = "1vnrvf245ijfyxzjbj9dr6i1hkjbyrh4yj88865wv9bs75axc5jv";
    };
  };
  "netrc" = {
    version = "0.10.3";
    source = {
      type = "gem";
      sha256 = "1r6cmg1nvxspl24yrqn77vx7xjqigpypialblpcv5qj6xmc4b8lg";
    };
  };
  "rack" = {
    version = "1.6.4";
    source = {
      type = "gem";
      sha256 = "09bs295yq6csjnkzj7ncj50i6chfxrhmzg1pk6p0vd2lb9ac8pj5";
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
  "rest-client" = {
    version = "1.8.0";
    source = {
      type = "gem";
      sha256 = "1m8z0c4yf6w47iqz6j2p7x1ip4qnnzvhdph9d5fgx081cvjly3p7";
    };
    dependencies = [
      "http-cookie"
      "mime-types"
      "netrc"
    ];
  };
  "sinatra" = {
    version = "1.4.6";
    source = {
      type = "gem";
      sha256 = "1hhmwqc81ram7lfwwziv0z70jh92sj1m7h7s9fr0cn2xq8mmn8l7";
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
  "tilt" = {
    version = "2.0.1";
    source = {
      type = "gem";
      sha256 = "1qc1k2r6whnb006m10751dyz3168cq72vj8mgp5m2hpys8n6xp3k";
    };
  };
  "unf" = {
    version = "0.1.4";
    source = {
      type = "gem";
      sha256 = "0bh2cf73i2ffh4fcpdn9ir4mhq8zi50ik0zqa1braahzadx536a9";
    };
    dependencies = [
      "unf_ext"
    ];
  };
  "unf_ext" = {
    version = "0.0.7.1";
    source = {
      type = "gem";
      sha256 = "0ly2ms6c3irmbr1575ldyh52bz2v0lzzr2gagf0p526k12ld2n5b";
    };
  };
}