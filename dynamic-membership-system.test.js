const { assertEquals, assertRejects } = require('@stacks/clarinet');
const { chain } = require('@stacks/clarinet');

describe('Dynamic Membership System', () => {
    
    it('should add a new member', async () => {
        const block = await chain.mineBlock([
            chain.callContract('dynamic-membership-system.add-member', ['SP2Q5YXZ8JKC0F7N6Z9S0D5XRTW57S1C9E']),
        ]);
        assertEquals(block.receipts[0].result, '(ok "New member added!")');
    });

    it('should remove an existing member', async () => {
        // First, add a member
        await chain.mineBlock([
            chain.callContract('dynamic-membership-system.add-member', ['SP2Q5YXZ8JKC0F7N6Z9S0D5XRTW57S1C9E']),
        ]);

        const block = await chain.mineBlock([
            chain.callContract('dynamic-membership-system.remove-member', ['SP2Q5YXZ8JKC0F7N6Z9S0D5XRTW57S1C9E']),
        ]);
        assertEquals(block.receipts[0].result, '(ok "Member removed!")');
    });

    it('should check member status', async () => {
        // Add a member
        await chain.mineBlock([
            chain.callContract('dynamic-membership-system.add-member', ['SP2Q5YXZ8JKC0F7N6Z9S0D5XRTW57S1C9E']),
        ]);

        const block = await chain.mineBlock([
            chain.callContract('dynamic-membership-system.check-member', ['SP2Q5YXZ8JKC0F7N6Z9S0D5XRTW57S1C9E']),
        ]);
        assertEquals(block.receipts[0].result, '(ok "Member status: true")');
    });
});
