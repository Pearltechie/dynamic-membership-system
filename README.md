# Dynamic Membership System

This repository contains a Clarity smart contract for a dynamic membership system. Users can purchase memberships with varying levels and durations, renew their memberships, and query their membership status.

# Features
- Purchase memberships (Basic and Premium)
- Memberships expire after a certain number of blocks
- Renew memberships before or after expiry
- Query membership details, including expiry

# Membership Levels
- Basic Membership:
  - Fee: 1000 STX
  - Duration: 30 blocks
- Premium Membership:
  - Fee: 5000 STX
  - Duration: 90 blocks

# Methods
1. `purchase-membership (level uint)`:
   - Levels: `1` (Basic) or `2` (Premium)
   - Returns: Expiry block height
2. `renew-membership`:
   - Renews the user's current membership
   - Returns: New expiry block height
3. `get-membership (member principal)`:
   - Query the membership level and expiry
   - Returns: Membership details

# Deployment
Deploy the `membership.clar` contract to the Stacks blockchain and ensure the recipient address in `stx-transfer?` is replaced with the correct address.

# Tests
This contract has been tested for:
- Valid membership purchases
- Expiry and renewal logic
- Invalid membership level handling
