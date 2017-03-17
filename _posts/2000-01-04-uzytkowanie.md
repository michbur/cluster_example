---
title: "Dostęp"
bg: '#ffa64d'
color: black
fa-icon: terminal
---

W celu użycia klastra w katalogu *share* należy przygotować skrypt zarządzający kolejką (**queue.sh**) i skrypt pojedynczego zadania. Przykładowe skrypty można pobrać z [repozytorium klastra](https://github.com/michbur/studencki-klaster-obliczeniowy/tree/master/projects/project000).

Przykładowy plik queue.sh.

{% highlight bash %} #!/bin/bash

iterator=1

while [ ${iterator} -le 2 ] do

./single_job.sh ${iterator}

iterator=$((iterator+1)) done {% endhighlight %}

Należy się upewnić, że oprogramowanie (w tym kompilatory) niezbędne do wykonania obliczeń jest zainstalowane na klastrze. Kompilację programu należy wykonywać na jednym z węzłów po zalogowaniu się tam za pomocą ssh.

Listę dostępnych w danej chwili węzłów można uzyskać za pomocą komendy *pbsnodes*.

Inne informacje o użytkowniu klastrów opartych na TORQUE można znaleźć np. [TUTAJ](http://qcd.phys.cmu.edu/QCDcluster/pbs/run_serial.html).
