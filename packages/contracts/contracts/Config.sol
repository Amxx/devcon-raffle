// SPDX-License-Identifier: UNLICENSED

pragma solidity 0.8.10;

abstract contract Config {
    // The use of _randomMask and _bidderMask introduces an assumption on max number of participants: 2^32.
    // The use of _bidderMask also introduces an assumption on max bid amount: 2^224 wei.
    // Both of these values are fine for our use case.
    uint256 constant _randomMask = 0xffffffff;
    uint256 constant _randomMaskLength = 32;
    uint256 constant _winnersPerRandom = 256 / _randomMaskLength;
    uint256 constant _bidderMask = _randomMask;
    uint256 constant _bidderMaskLength = _randomMaskLength;

    uint256 public immutable _biddingStartTime;
    uint256 public immutable _biddingEndTime;
    uint256 public immutable _claimingEndTime;
    uint256 public immutable _auctionWinnersCount;
    uint256 public immutable _raffleWinnersCount;
    uint256 public immutable _reservePrice;
    uint256 public immutable _minBidIncrement;

    constructor(
        uint256 biddingStartTime_,
        uint256 biddingEndTime_,
        uint256 claimingEndTime_,
        uint256 auctionWinnersCount_,
        uint256 raffleWinnersCount_,
        uint256 reservePrice_,
        uint256 minBidIncrement_
    ) {
        require(auctionWinnersCount_ > 0, "Config: auction winners count must be greater than 0");
        require(raffleWinnersCount_ > 0, "Config: raffle winners count must be greater than 0");
        require(raffleWinnersCount_ % _winnersPerRandom == 0, "Config: invalid raffle winners count");
        require(biddingStartTime_ < biddingEndTime_, "Config: bidding start time must be before bidding end time");
        require(biddingEndTime_ < claimingEndTime_, "Config: bidding end time must be before claiming end time");
        require(reservePrice_ > 0, "Config: reserve price must be greater than 0");
        require(minBidIncrement_ > 0, "Config: min bid increment must be greater than 0");

        _biddingStartTime = biddingStartTime_;
        _biddingEndTime = biddingEndTime_;
        _claimingEndTime = claimingEndTime_;
        _auctionWinnersCount = auctionWinnersCount_;
        _raffleWinnersCount = raffleWinnersCount_;
        _reservePrice = reservePrice_;
        _minBidIncrement = minBidIncrement_;
    }

    function biddingStartTime() external view returns (uint256) {
        return _biddingStartTime;
    }

    function biddingEndTime() external view returns (uint256) {
        return _biddingEndTime;
    }

    function claimingEndTime() external view returns (uint256) {
        return _claimingEndTime;
    }

    function auctionWinnersCount() external view returns (uint256) {
        return _auctionWinnersCount;
    }

    function raffleWinnersCount() external view returns (uint256) {
        return _raffleWinnersCount;
    }

    function reservePrice() external view returns (uint256) {
        return _reservePrice;
    }

    function minBidIncrement() external view returns (uint256) {
        return _minBidIncrement;
    }
}
