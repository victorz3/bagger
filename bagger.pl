/* Bagger program
 * Third homework of Expert Systems course
 * Author: Victor Zamora */

% Database of items.
item(bread).
item(glop).
item(granola).
item(ice_cream).
item(chips).

% Container material of items.
container(bread, plastic).
container(granola, cardboard).
container(ice_cream, cardboard).
container(chips, plastic).

% Type of container.
type(bread, bag).
type(glop, jar).
type(granola, box).
type(ice_cream, carton).
type(pepsi, bottle).
type(chips, bag).

% Size of container.
size(bread, medium).
size(glop, small).
size(granola, large).
size(ice_cream, medium).
size(pepsi, large).
size(chips, medium).

% Whether item is frozen.
frozen(ice_cream).

% Defining orders.
order(L) :- forall(member(X, L), item(X)).

/* Packing an order means doing the four steps in the text.
 * We'll say that L1 (list of items) packs in L2 (list of bags with items)
 * if this predicate is true. */
pack(L1, B) :- order(L1), check_order(L1, L2), pack_large_items(L2, L3),
	       pack_medium_items(L3, L4), pack_small_items(L4, B).


% Step check-order.

% Rule B1.
check_order(L1, L2) :- member(chips, L1), not(member(pepsi, L1)),
		       L2 = [pepsi | L1].




