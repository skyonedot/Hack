PancakeSwapRouterV2: https://bscscan.com/address/0x10ed43c718714eb63d5aa57b78b54704e256024e#code

PancakeSwapFactoryV2: https://bscscan.com/address/0xca143ce32fe78f1f7019d7d551a6402fc5350c73#code

​    Pair 的代码在 Factory 中, 不过为了方便起见, 把 Pair 的代码分别拿出来了.





V2 Docs:

https://docs.pancakeswap.finance/code/smart-contracts/pancakeswap-exchange/v2



V3 Docs:

https://docs.pancakeswap.finance/code/smart-contracts/pancakeswap-exchange/v3



---

注意看 PancakeRouterV2中的这段代码, 这个函数计算的是, 你需要付出多少的 amountIn (即返回值)

```solidity
    // given an output amount of an asset and pair reserves, returns a required input amount of the other asset
    function getAmountIn(uint amountOut, uint reserveIn, uint reserveOut) internal pure returns (uint amountIn) {
        require(amountOut > 0, 'PancakeLibrary: INSUFFICIENT_OUTPUT_AMOUNT');
        require(reserveIn > 0 && reserveOut > 0, 'PancakeLibrary: INSUFFICIENT_LIQUIDITY');
        uint numerator = reserveIn.mul(amountOut).mul(10000);
        uint denominator = reserveOut.sub(amountOut).mul(9975);
        amountIn = (numerator / denominator).add(1);
    }
```

最后三行 的数学理论推导如下

1. 当前Pair中 Token0 是 x , Token1 是 y, 因此 池子的代币余额为 $x_0, y_0$ 
2. 我想用 $∆y_0$ 换取 $∆x_0$ , 即我想要付出一定量的Token y, 来换取一定量的 Token x
3. 那么 在上面的函数传参, 分别是 $∆x_0, y_0, x_0$ 这样传
4. 相应的数学推导如下
   1. $x_0 * y_0 = (x_0 - ∆x_0)*(y_0 + ∆y_0)$  因为对于池子来说, 是多了$y_0$(+) , 少了$x_0$(-)
   2. 因此 可以推出 $∆y = \frac{∆x_0 * y_0}{x_0 - ∆x_0}$ 
5. 因此 和上面最后三行代码匹配, 至于分子✖️10000, 分母是9975, 是因为V2的手续费固定是 0.25% 参见这里的手续费参数   https://docs.pancakeswap.finance/products/pancakeswap-exchange/pancakeswap-pools#earning-trading-fees-1 (V3可以自己定制)
6. 最后add 1则是因为 需要让amountIn 进来的多一些 (和solidity的取整有关系, 因为它取整并不是四舍五入, 而是把小数位置的数字全部去掉)





-----

假设现在是Token A去换取Token B

swapExactTokensForTokens(amountIn, amountOutMin, path, to, deadline)
    参数分别是 A进去的数量, B最少出来的数量, 路径, 给谁, deadline


    
swapTokensForExactTokens(amountOut, amountInMax, path, to, deadline)
    参数分别是, B出来的数量, A最多进去多少, 路径, 给谁, ddl



现在换成了ETH 来 换 Token B

swapExactETHForTokens(amountOutMint, path, to, ddl) 记得给Value
    参数分别是: 最少出来多少Amount B, 路径 ,给谁, ddl
    这个需要确保 是原生WETH 和 TokenB的配对, 路径的第一个参数需要是WETH的地址

swapTokensForExactETH(amountOut, amountInMax, path, to, ddl)
    这个是用 Token B 换 ETH, path的最后一步需要是WETH, 因为最后一步将WETH转成ETH 发过来
    参数分别是: 想要多少ETH出来, B最多进去多少, 路径, 给谁, ddl

swapExactTokensForETH(amountIn, amountOutMin, path, to, ddl)
    这是用 具体的TokenB数量, 换 ETH
    参数分别是, B进去多少, ETH最少出来多少, 路径, 给谁, ddl

swapETHForExactTokens(amountOut, path, to, ddl) 记得发送Value
    这是用ETH 去换 具体的TokenB
    参数分别是, B出来多少, path(记得第一个是WETH) 给谁, ddl
    