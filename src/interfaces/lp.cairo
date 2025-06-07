#[starknet::interface]
pub trait ILiquidityProvider<TStorage> {
    /// creates and initializes a pool with ekubo key `pool_key` with initial tick `initial_tick`.
    /// only owner of liquidity provider can initialize
    fn create_and_initialize_pool(
        ref self: TStorage,
        pool_key: ekubo::types::keys::PoolKey,
        initial_tick: ekubo::types::i129::i129,
        profile_params: Span<ekubo::types::i129::i129>,
    );

    /// compounds any existing fees on pool with ekubo key `pool_key` into the liquidity factor
    fn compound_fees(ref self: TStorage, pool_key: ekubo::types::keys::PoolKey) -> u128;

    /// adds an amount of liquidity factor to pool with ekubo key `pool_key`, minting shares to
    /// caller
    fn add_liquidity(
        ref self: TStorage,
        pool_key: ekubo::types::keys::PoolKey,
        factor: u128,
        amount0_max: u128,
        amount1_max: u128,
    ) -> u256;

    /// removes an amount of liquidity factor from pool with ekubo key `pool_key`
    fn remove_liquidity(
        ref self: TStorage,
        pool_key: ekubo::types::keys::PoolKey,
        shares: u256,
        amount0_min: u128,
        amount1_min: u128,
    ) -> u128;

    /// sweeps any tokens in this contract to recipient. only callable by owner
    fn sweep(
        ref self: TStorage,
        token: starknet::ContractAddress,
        recipient: starknet::ContractAddress,
        amount: u256,
    );

    /// returns the ekubo core for pools deployed by this liquidity provider
    fn core(self: @TStorage) -> ekubo::interfaces::core::ICoreDispatcher;

    /// returns the profile for pools deployed by this liquidity provider
    fn profile(self: @TStorage) -> spline::interfaces::profile::ILiquidityProfileDispatcher;

    /// returns the liquidity provider token for pool with ekubo key `pool_key`
    fn pool_token(
        self: @TStorage, pool_key: ekubo::types::keys::PoolKey,
    ) -> starknet::ContractAddress;

    // returns the current liquidity factor for pool with ekubo key `pool_key`
    fn pool_liquidity_factor(self: @TStorage, pool_key: ekubo::types::keys::PoolKey) -> u128;

    // returns the current reserves available for swaps on pool with ekubo key `pool_key`,
    // excludes fees accumulated on pool
    fn pool_reserves(self: @TStorage, pool_key: ekubo::types::keys::PoolKey) -> (u128, u128);

    /// returns the minimum liquidity factor for pool with ekubo key `pool_key` for pool price at
    /// given tick
    fn pool_minimum_liquidity_factor(
        self: @TStorage, pool_key: ekubo::types::keys::PoolKey, tick: ekubo::types::i129::i129,
    ) -> u128;
}
