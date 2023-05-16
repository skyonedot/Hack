不知道为什么, 我setup里面有 vm.setselectfork(bsc), 然后运行
forge test --match-path ./test/PancakePair.t.sol  -vvvv
不通过

必须是这个
(注释掉VM.createSelectFork这句话)
forge test --match-path ./test/PancakePair.t.sol  -vv a


如果有 VM.createSelectFork 这句话 
forge test --match-path ./test/PancakePair.t.sol  -vv

forge test --contracts ./test/PancakePair.t.sol-vvv



forge test --contracts ./test/PancakePair.sol-vvv



forge test --match-path ./src/test/Pancake.sol -vvv --rpc-url https://bsc-mainnet.blockvision.org/v1/2PKWABFaz7ofRR8e81An2dM6T1e


forge test --contracts ./src/test/Pancake.sol -vvv --rpc-url https://bsc-mainnet.blockvision.org/v1/2PKWABFaz7ofRR8e81An2dM6T1e

如果是
.src
.test
这种情况下 即并列  forge test --match-path 可以运行一个  forge test --contracts这个是全运行

如果是
.src
    .test
这种情况下 即隶属  forge test --match-path And forge test --contracts 这两个 都可以 运行某一个 

好吧, 大概知道是什么情况了, 
如果有Mint Token, 发代笔的这种情况 还想要用其余网络上的Router, 那就只能 带有rpc, 而且还不能有createSelectFolk这些
如果, 只是网络上的Router等等, 那就可以createSelectFork 