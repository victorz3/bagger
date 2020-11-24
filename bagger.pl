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

% Auxiliary predicate to delete one element from a list.
delete_one(_, [], []).
delete_one(X, [A|AS], L2) :- X == A, L2 = AS, !.
delete_one(X, [A|AS], L2) :- delete_one(X, AS, L3), L2 = [A|L3].

% Defining orders.
order(L) :- forall(member(X, L), item(X)).

% Auxiliary predicate to put an item in a bag.
put_in_bag(B, I, L1, L2) :- delete_one(B, L1, L3), delete_one(I, L3, L4), L2 = [[I|B]|L4].

/* Packing an order means doing the four steps in the text.
 * We'll say that L1 (list of items) packs in L2 (list of bags with items)
 * if this predicate is true. */
pack(L1, B) :- order(L1), check_order(L1, L2), pack_large_items(L2, B).


% Step check-order.

% Rule B1.
check_order(L1, L2) :- member(chips, L1), not(member(pepsi, L1)),
		       L2 = [pepsi | L1], !.
% Rule B2.
check_order(L1, L1).

% Step pack-large-items

% Checks whether there are large items on the list.
large_items([X | _]) :- size(X, large), !.
large_items([_ | XS]) :- large_items(XS).

% Escape clause.
pack_large_items(L, L) :- not(large_items(L)), !.

% Rule B3.
pack_large_items(L1, L2) :- size(X, large), type(X, bottle), member(X, L1), member(L, L1), is_list(L), length(L, K), K < 6, put_in_bag(L, X, L1, L3), pack_large_items(L3, L2), !.

% Rule B4.
pack_large_items(L1, L2) :- size(X, large), member(X, L1), member(L, L1), is_list(L), length(L, K), K < 6, put_in_bag(L, X, L1, L3), pack_large_items(L3, L2), !. 

% Rule B5.
pack_large_items(L1, L2) :- size(X, large), member(X, L1), L3 = [[]|L1], pack_large_items(L3, L2),!.
