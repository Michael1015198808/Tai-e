#!/bin/bash
for cs in ci 2-obj 2-cfa 2-type
do
    for x in `ls test-true-$cs`
    do
        diff \
            <(grep '^#' test-true-$cs/$x/tai-e.log) \
            <(grep '^#' test-false-$cs/$x/tai-e.log);
        # Compare statistics only
    done
    echo "$cs tests finished! (If no \`diff\` message was shown, the tests are passed!)"
done
