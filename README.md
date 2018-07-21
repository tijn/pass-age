# pass age

A [pass](https://www.passwordstore.org) extension that can show you how long you are using a certain password.

## Why

- Why not?
- It could be useful to use for password rotation

## Requirements

These commands assume you're using pass together with git. It won't do much if it cannot examine older versions of your password files.

## Installation

1. Enable pass [extensions](https://www.passwordstore.org/#extensions).
2. Copy or symlink `age.bash` and `ages.bash` into your `~/.password-store/.extensions` directory.


## How to use

### Show the age of one password

```terminal
pass age amazon.com
```

This command will figure out when you last changed the first line of the `amazon.com.gpg` file. It will output the unix-timestamps, a human readable version of that timestamp, and the name of the file. This is convenient for further processing with `sort` or `grep` or `awk`.

### Show password ages of all passwords

```terminal
pass ages
```

or, if you're only interested in a certain set of passwords in a subdirectory, say your passwords for work:

```terminal
pass ages work
```

Note that this command can be very slow as it likely has to decrypt multiple versions of each password file.

### Get help

```terminal
pass age --help
pass ages --help
```

This will show you how to use the commands... but not much more. Sorry.

## Advanced usage

### Show password ages of all passwords, sorted by age, youngest first

```terminal
pass ages | sort -r
# or
pass ages subdirectory | sort -r
```

### Show the oldest three passwords

```terminal
pass ages | sort -r | tail -n 3
```
