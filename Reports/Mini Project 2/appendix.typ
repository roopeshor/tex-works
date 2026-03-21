// Disable chapter numbering
#show heading.where(level: 1): it => {
  set align(center + top)
  pagebreak(weak: true)
  block[
    #v(0.5cm)
    #text(size: 24pt, weight: "bold")[#it.body]
    #v(1cm)
  ]
}
#counter(heading).update(0)
#set heading(numbering: "A.1")
= Appendices <unnumbered>
== Code

```cpp
int main() {
  return 0;
}
```

== Additional references
