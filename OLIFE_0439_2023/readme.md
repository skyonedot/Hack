3% REFLECTED BACK TO HOLDERS //CHARITY, TEAM AND MARKETING WALLET DONT GET DISTRIBUTIONS
6% IS TRANSACTION TAX //CHARITY(4%)/MARKETING WALLET(2%) (DIVIDED 66% AND 33%)
2% IS BURNED AUTOMATICALLY - STRAIGHT FROM TOKEN SUPPLY



这俩显示的资金流向还不太一样 

https://eigenphi.io/mev/eigentx/0xa21692ffb561767a74a4cbd1b78ad48151d710efab723b1efa5f1e0147caab0a
  从这个资金流向 和 Event 两方面来看
    先看开始给自己转移的这两步 https://bscscan.com/tx/0xa21692ffb561767a74a4cbd1b78ad48151d710efab723b1efa5f1e0147caab0a#eventlog 
      对应tx event中的17--18配套
         ```
         >>> a = 8925616
        >>> b = 132396644
        >>> a/(b+a)
        0.0631578917574627
         ```
         即每次发送tx, 加入发送100个Olife Token(假设双方都是普通人), 那么则是会有 6.3个 进入 Charity的钱包
         
https://explorer.phalcon.xyz/tx/bsc/0xa21692ffb561767a74a4cbd1b78ad48151d710efab723b1efa5f1e0147caab0a

池子地址: https://bscscan.com/address/0x915c2dfc34e773dc3415fe7045bb1540f8bdae84
Token地址: https://bscscan.com/token/0xb5a0ce3acd6ec557d39afdcbc93b07a1e1a9e3fa

Deliver 和 transfer 两个function 改变了 tSupply 和 rSupply, 以至于余额的改动

Charity地址: https://bscscan.com/address/0xdc57ccd9e2a1d89e1e6a9dd8fdc8d54636b286e6 ()


// @Analysis
// https://twitter.com/BeosinAlert/status/1648520494516420608
    ~~这里可能说的不太对, 因为 transfer 的确会改变 _tTotal(减小), 但是 _tTotal的减小会让balance变小, 并不会increase 增加~~, 而是deliver 会改变 _rOwned[msg.sender] 以及 _rTotal, 使得这俩减少, 因此 可能的确造成余额的增大
// @TX
// https://bscscan.com/tx/0xa21692ffb561767a74a4cbd1b78ad48151d710efab723b1efa5f1e0147caab0a
// @Summary
// The attacker called the `transfer()` and `deliver()` functions to reduce the number of rSupply and tSupply.
// The value of rate is thus calculated less, increasing the number of reflected tokens in the pair, 
// Finally directly call swap to withdraw $WBNB from the pair.

重点在 olife_simulate_hack.sol 的 80行, 利用给自己transfer + deliver 的方式, 改变了池子的余额

看下面log, 池子的Olife代币余额 从 5583143 变成了 217839506118721725361
用户自己的Token 余额 则是从     148760274 -->   16499689513508949904
那这样来看, 池子里的Token 多了, 而用户自己手中的Token 少了啊 [虽然 有违背常理, 即我们应该让池子里的Token 减少以拉升价格 比如Tata, 但是这个 它就是这样]

如下 是池子余额里的变化, 最后一步获利Swap 则是利用 260000000000000000 换出来了 1001WBNB
```
  [Pool Info] Nothing Happened, Pair Pool OLIFE balance: 161703370.635833872
  [Pool Info] Nothing Happened, Pair Pool WBNB balance: 32.286315327689621042
  [Pool Info] Had First Swap, But Hack Not Happened, Pair Pool OLIFE balance: 217839506118721725361.721643770
  [Pool Info] Had First Swap, But Hack Not Happened, Pair Pool WBNBs balance: 1001.286315327689621042
  [Pool Info] Had Second Swap,  Hack Had Happened, Pair Pool OLIFE balance: 442800193798677325280.332498353
  [Pool Info] Had Second Swap, Hack Had Happened, Pair Pool WBNBs balance: 0.000000000012656580
```
不应该啊, 因为 进去了 260000000000000000 而余额 从 217839506118721725361 --> 442800193798677325280 这个量级, 对不上诶 🍄疑点四


最后是因为什么 可以用 260000000000000000(则是自己用Router代码的数量) 换出来10010个WBNB的? 疑点三 🍄
   根据tx event, hacker是用 217839506118716142218517859523 换出来了 


transfer + deliver 的 Log
```
Logs:
  [INFO] OLIFE amount in pair before the currentRate reduction: 5583143.203784247
  [INFO] OLIFE amount in hack contract before the currentRate reduction: 148760274.602488242
  [INFO] OLIFE amount in pair after the currentRate reduction: 217839506118721725361.721643770
  [INFO] OLIFE amount in hack contract after the currentRate reduction: 16499689513508949904.965052673
  [INFO] oldOlifeReserve: 5583143.203784247
  [INFO] amountin: 217839506118716142218.517859523
  [INFO] swapAmount: 1001.286315327663894139
  [End] Attacker WBNB balance after exploit: 32.286315327663894139
```

单纯transfer 给自己 19次 的 Log
```
Logs:
  [INFO] OLIFE amount in pair before the currentRate reduction: 5583143.203784247
  [INFO] OLIFE amount in hack contract before the currentRate reduction: 148760274.602488242
  [INFO] OLIFE amount in pair after the currentRate reduction: 23582704.382275693
  [INFO] OLIFE amount in hack contract after the currentRate reduction: 68645478.595486866
  [INFO] oldOlifeReserve: 5583143.203784247
  [INFO] amountin: 17999561.178491446
  [INFO] swapAmount: 763.781224129513220172
```

从结果来看, 单纯 给自己 transfer 池子里的Token 从 558w 变成了 2358万
                              自己的钱包余额 则是 从 14876万 变成了 6864万

这是单纯给自己 transfer 一次的结果
```
Logs:
  [INFO] OLIFE amount in pair before the currentRate reduction: 5583143.203784247
  [INFO] OLIFE amount in hack contract before the currentRate reduction: 148760274.602488242
  [INFO] OLIFE amount in pair after the currentRate reduction: 5965834.964275918
  [INFO] OLIFE amount in hack contract after the currentRate reduction: 141471658.788257173
  [INFO] oldOlifeReserve: 5583143.203784247
  [INFO] amountin: 382691.760491671
  [INFO] swapAmount: 64.079440964494290645

```
不对啊, 单纯给自己transfer, 为什么会使得 池子的余额增加呢?  疑点2 🍄 已解决
  每个account的balanceOf都是 (_rOwned[msg.sender]*tSupply) / rSupply, 而给自己transfer 会导致 _tTotal减少, 也会导致 _rTotal减少, 因为 `_reflectFee` 第一行和倒数第一行 是改变这俩值的, 
    那么只要 _rTotal 减少的多, 则 池子的余额就是上升的



-----


那么deliver的作用是什么? 
deliver, 除了对自己, 其余的对总体的影响 只有 使得 _rTotal 减少了 减少了 rAmount 的数量, 对于池子余额来说, 也是增大了


第一步Swap的时候 即WBNB --> OLIFE时, 利用的是 pancakeRouter.swapExactTokensForTokensSupportingFeeOnTransferTokens

第二部Swap, 即OLIFE --> WBNB, 利用的是 OLIFE_WBNB_LPPool.swap
// 疑点1 🍄
// 已经解决, 用pancakeRouter 或者 自己的LP都可以实现, 不过代码有一定出入, 详情参看 https://github.com/skyonedot/DeFiHackLabs/blob/61af80870b8c2261cf51acc070b49a50788c7b1b/src/test/OLIFE_exp.sol#L106