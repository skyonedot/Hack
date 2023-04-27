项目方Twitter: https://twitter.com/AxiomaHolding
TX: https://bscscan.com/tx/0x05eabbb665a5b99490510d0b3f93565f394914294ab4d609895e525b43ff16f2
https://explorer.phalcon.xyz/tx/bsc/0x05eabbb665a5b99490510d0b3f93565f394914294ab4d609895e525b43ff16f2
核心的点 在于  7. 发送536.25 到 AXT之后, 
             8.9. 用9213.75 换出来了 53个BNB

Sec: Axioma_exp.sol

token axt: 0xB6CF5b77B92a722bF34f6f5D6B1Fe4700908935E
presale: 0x2C25aEe99ED08A61e7407A5674BC2d1A72B5D8E3
    - presale 价格是 buyToken 这个function
    - endsale 是把所有的 axt转走, 以达到end的目的
    - 设定的 Tax 是 0, 所以不需要交税
    - 价格是 1BNB = 300 AXT (1e18 * 3e11 / 1e9) = 3e20 / 1e18 = 3e2 = 300
        所以 一笔sale https://bscscan.com/tx/0x1d3cc19e5a25569377c950053cca59cd843c6ad3400b2336df27668ed2b0c002 .0034BNB买了 1.02 AXT

axt_wbnb_pair: 0x6a3Fa7D2C71fd7D44BF3a2890aA257F34083c90f cake的池子

dodo flashloan wbnb-usdt 0xFeAFe253802b77456B4627F8c2306a9CeBb5d681


DODO的三种闪电贷
1. DVM(DODO Vending Machine) (管理流动性) https://dodoex.github.io/docs/docs/publicPool
    引用苹果市场的建立 来阐述原理
    使用案例
    1. 你想发Token 总量10m, 自己留10k, 剩下的9.9m都用作流动性, 但是另一方也需要钱, 当然, 可以拿一部分Token来做流动性, 但是这样不允许大量买单的进入, 因此你可以用DVM来做
    2. 维持某个Pair的流动性
    3. 控制代币的暴涨暴跌, 有一个参数, 可以进行控制

2. DPP(DODO Private Pool) (DVM高级版) https://dodoex.github.io/docs/docs/privatePool
    - 针对专业做市商的, 尤其是DVM无法满足需求的时候
    - 使得做市商具有以下能力:
        1. 单边存款/去款(DVM需要双边)
        2. 随时改变定价曲线(DVM在创建后无法改变)
        3. 在0到正无穷范围内拥有流动性
    - 对PMM算法进行了更深 层次的灵活性, 配置性的产品
    - 使用案例
        1. 降低下跌风险, 当市场发生波动的时候, 可以移除一些买方流动性(即 提取预计会贬值比较厉害的代币)
        2. 当预计到价格将要剧烈波动的时候, 传统AMM只能通过两种方式
            1. 自己买大量的Token
            2. 移除掉大量的流动性
            这两种方法都不好, 而DPP 可以改善这种体验, 允许直接干预市场和调整价格
        3. 恒定价格市场, 设定K为0
        4. 回归传统AMM, 调整K值即可, 当K=1的时候, 即与AMM相同
        5. 市值管理(累死于上面的DVM)

3. DCP(DODO Crowdpooling)
    - Dex上面主要的三种流动性方法
        1. Bonding Curve(FrontRunning)
        2. AMM coupled with yield farming
        3. Auction
    - CrowdPooling 是 CrowdFunding 和 Liquidity Pool 的 集合代名词
    - 建立池子的Tx Fee 由项目方补贴,任何人都可以触发创建池子
    - 流动性保护期 
    - 为不同用户设定不同的配置
    - CrowdPooling 没有 FrontRunning的问题, 与 AMM相比又没有代币膨胀(Farm)的问题, 募集到的资金不会滥用, 而是创建一个流动性市场


从SEC来看, 是一个很正常的 闪电贷在Presale买, 然后在Pancake出售, 即可获利
    问题点在于 拿到 9750个代币之后, 在pancakeswap的时候, 价差, 并不是自己发送的Token, 而是Swap的Tax
        
balanceOf 和 balances 都没有重写 
每次tranfer 都会有 
    dividendTracker.setBalance(payable(from), balanceOf(from));
    dividendTracker.setBalance(payable(to), balanceOf(to));
 
其实不需要看太细, 去看图标发现 4.20号的时候 价格已经比预售高很多了, 这时候直接无脑去买预售, 然后直接Pancake卖都成, 闪电贷就是一个Buff

https://dexscreener.com/bsc/0x6a3fa7d2c71fd7d44bf3a2890aa257f34083c90f
