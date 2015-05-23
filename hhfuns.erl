-module(hhfuns).
-compile(export_all).

one() -> 1.
two() -> 2.

add(X, Y) -> X() + Y().

increment([]) -> [];
increment([H|T]) -> [H+1 | increment(T)].

decrement([]) -> [];
decrement([H|T]) -> [H-1 | decrement(T)].

map(_, []) -> [];
map(F, [H|T]) -> [F(H) | map(F, T)].

incr(X) -> X + 1.
decr(Y) -> Y - 1.

even(L) -> lists:reverse(even(L, [])).

even([], Acc) -> Acc;
even([H|T], Acc) when H rem 2 == 0 ->
  even(T,[H|Acc]);
even([_|T], Acc) ->
  even(T,Acc).

old_men(L) -> lists:reverse(old_men(L, [])).

old_men([Person = {male, Age}|People], Acc) when Age > 60 ->
  old_men(People, [Person|Acc]);
old_men([_|T], Acc) ->
  old_men(T, Acc).

filter(F, L) -> lists:reverse(filter(F, L, [])).
filter(_, [], Acc) -> Acc;
filter(F, [H|T], Acc) ->
  case F(H) of
    true -> filter(F, T, [H|Acc]);
    false -> filter(F, T, Acc)
  end.

max([H|T]) -> mymax(T, H).
mymax([], Max) -> Max;
mymax([H|T], Max) when H > Max ->
  mymax(T, H);
mymax([_|T], Max) ->
  mymax(T, Max).

min([H|T]) -> mymin(T, H).
mymin([], Min) -> Min;
mymin([H|T], Min) when H < Min ->
  mymin(T, H);
mymin([_|T], Min) ->
  mymin(T, Min).

sum(L) -> sum(L, 0).
sum([], Acc) -> Acc;
sum([H|T], Acc) -> sum(T, H + Acc).

fold(_, [], Acc) -> Acc;
fold(F, [H|T], Acc) ->
  fold(F, T, F(H, Acc)).
