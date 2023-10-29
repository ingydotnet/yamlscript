---
layout: home
title: YAMLScript.org
---

#### YAMLScript — Program in YAML

YAMLScript is a functional programming language whose syntax is encoded in YAML.
YAMLScript can be used for writing new software applications and libraries.

Here's an example of a YAMLScript program called `hello.ys`:

```yaml
--- !yamlscript/v0
defn main(name="world"):
  say: "Hello, $name!"
```

You can run this program from the command line:

```bash
$ ys hello.ys
Hello, world!
$ ys hello.ys Bob
Hello, Bob!
```

YAMLScript can also be used in plain YAML files to add dynamic operations at any
level.
Here's an example of using YAMLScript in a YAML file `db-config.yaml`:

```yaml
--- !yamlscript/v0
require: ys.yaml

base =::
  ys.yaml/load-file: "db-defaults.yaml"
  # host: localhost
  # port: 12345
  # user: app
  # password: secret

do::
  development:
    ! merge base::
      user: dev
      password: devsecret

  staging:
    ! merge base::
      host: staging-db.myapp.com

  production:
    ! merge base::
      host: prod-db.myapp.com
      user: prod
      password: prodsecret
```

From the command line, run:

```bash
$ ys --load db-config.yaml
[{"development":
  {"host":"localhost", "port":12345, "user":"dev", "password":"devsecret"}},
 {"staging":
  {"host":"staging-db.myapp.com", "port":12345, "user":"app", "password":"secret"}},
 {"production":
  {"host":"prod-db.myapp.com", "port":12345, "user":"prod", "password": "prodsecret"}}]
```

By default YAMLScript outputs JSON, but it can also output YAML by running:

```bash
$ ys --load --yaml db-config.yaml
```

You can also use YAMLScript as a module in another language like Python:

```python
import yamlscript as ys
config = ys.load_file("db-config.yaml")
```

See the [YAMLScript Docs](https://yamlscript.org/doc/) for more information.
