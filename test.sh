#!/bin/bash
for cs in ci 2-obj 2-cfa 2-type
do
    mkdir -p test-true-$cs test-false-$cs
    java -ea -cp build/classes/java/test:build/tai-e-all-0.5.2-SNAPSHOT.jar pascal.taie.analysis.pta.BenchmarkRunner -cs $cs -test true
    java -ea -cp build/classes/java/test:build/tai-e-all-0.5.2-SNAPSHOT.jar pascal.taie.analysis.pta.BenchmarkRunner -cs $cs -test false
    for x in `ls test-true-$cs`
    do
        diff \
            <(grep '^#' test-true-$cs/$x/tai-e.log) \
            <(grep '^#' test-false-$cs/$x/tai-e.log);
        # Compare statistics only
    done
    echo "$cs tests finished! (If no \`diff\` message was shown, the tests are passed!)"
done
