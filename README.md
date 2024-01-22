<h1>ITrie</h1>

<p>
    <a href="https://github.com/SandroMaglione/itrie">
    <img src="https://img.shields.io/github/stars/SandroMaglione/itrie?logo=github" />
    </a>
    <!-- <img src="https://img.shields.io/pub/v/fpdart?include_prereleases" /> -->
    <img src="https://img.shields.io/github/license/SandroMaglione/itrie?logo=github" />
    <a href="https://github.com/SandroMaglione">
    <img alt="GitHub: SandroMaglione" src="https://img.shields.io/github/followers/SandroMaglione?label=Follow&style=social" target="_blank" />
    </a>
    <a href="https://twitter.com/SandroMaglione">
    <img alt="Twitter: SandroMaglione" src="https://img.shields.io/twitter/follow/SandroMaglione.svg?style=social" target="_blank" />
    </a>
</p>


**Efficient, immutable and stack safe** implementation of a `Trie` data structure in dart.

`Trie` is ideal for **autocomplete**, **text search**, **spell checking**, and generally when working with string and prefixes.

- [💻 Installation](#-installation)
- [💡 How to use](#-how-to-use)
  - [Constructors](#constructors)
  - [`Iterable`](#iterable)
  - [Mutations (Immutable)](#mutations-immutable)
  - [Getters](#getters)
- [🛠️ Properties](#️-properties)
  - [Immutable](#immutable)
  - [Stack safe](#stack-safe)
  - [(Space) Efficient](#space-efficient)
- [📃 Versioning](#-versioning)
- [😀 Support](#-support)
- [👀 License](#-license)



## 💻 Installation

```yaml
# pubspec.yaml
dependencies:
  itrie: ^0.0.1
```

## 💡 How to use
The package export a single `ITrie` class.

### Constructors
An `ITrie` can be created from any `Iterable` or using the `empty` constructor:

```dart
/// Empty [ITrie] with [int] values
final empty = ITrie<int>.empty();
final copy = empty.insert("key", 10);

/// From [Iterable] containing a record of `(String, T)`
final fromIterable = ITrie.fromIterable([("key", 10)]);
```

### `Iterable`
`ITrie` extends `Iterable`.

This means that you have access to all the methods
available in the [Iterable API](https://api.dart.dev/stable/3.2.5/dart-core/Iterable-class.html#instance-methods):
- [`map`](https://api.dart.dev/stable/3.2.5/dart-core/Iterable/map.html)
- [`fold`](https://api.dart.dev/stable/3.2.5/dart-core/Iterable/fold.html)
- [`every`](https://api.dart.dev/stable/3.2.5/dart-core/Iterable/every.html)
- [`iterator`](https://api.dart.dev/stable/3.2.5/dart-core/Iterable/iterator.html)
- And more 🚀

### Mutations (Immutable)
Methods to add/remove/modify key/value inside `ITrie`:

```dart
final itrie = ITrie<int>.empty();

final insert = itrie.insert("key", 10);
final remove = itrie.remove("key");
final modify = itrie.modify("key", (value) => value + 1);
final insertMany = itrie.insertMany([("key2", 20)]);
final removeMany = itrie.removeMany(["key"]);
```

> 🧱 `ITrie` **is immutable**
> 
> These methods return a new copy of the original `ITrie`
> **without modifying the original** `ITrie`

### Getters
Methods to extract key/value based on `key` and `prefix`:

```dart
final itrie = ITrie<int>.empty();

final getV = itrie.get("key");
final longestPrefixOf = itrie.longestPrefixOf("keys");
final withPrefix = itrie.withPrefix("ke");
final keysWithPrefix = itrie.keysWithPrefix("ke");
final valuesWithPrefix = itrie.valuesWithPrefix("ke");
final keys = itrie.keys;
final values = itrie.values;
final length = itrie.length;
final has = itrie.has("key");
```

## 🛠️ Properties

### Immutable
The main difference between other trie implementations is that `ITrie` is **immutable**.

Every mutation (e.g. `insert`, `delete`, `modify`) returns a new instance of `ITrie` instead of modifying the original `ITrie` in-place.

```dart
final itrie = ITrie<int>.empty();
final newITrie = itrie.insert("key", 10); /// 👈 `insert` returns a new [ITrie]

expect(itrie.length, 0); /// 👈 Original `itrie` is not modified
expect(newITrie.length, 1);
```

> ✅ Immutability in `ITrie` uses a technique called **Path copying**: this makes `ITrie` efficient since it does not require to copy the full data structure with every mutation 

### Stack safe
`ITrie` does **not** use recursion. No matter how many operations or elements it contains, `ITrie` will never cause stack overflow issues.

### (Space) Efficient
`ITrie` is implemented internally as a **Ternary Search Trie**. This data structure allows for any alphabet size (any `String`) and it is also more space efficient compared to other trie implementations.


***


## 📃 Versioning

- v0.0.1 - 22 January 2024

## 😀 Support

If you are interested in my work you can [**subscribe to my newsletter**](https://www.sandromaglione.com/newsletter). 

For more frequent updates you can also follow me on my [**Twitter**](https://twitter.com/SandroMaglione).

## 👀 License

MIT License, see the [LICENSE.md](https://github.com/SandroMaglione/itrie/blob/main/LICENSE) file for details.
