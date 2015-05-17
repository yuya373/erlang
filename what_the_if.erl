-module(what_the_if).
-compile(export_all).

oh_god(N) ->
  if N =:= 2 -> might_suceed;
     true -> always_does
  end.

heh_fine() ->
  if 1 =:= 1 ->
       works
  end,
  if 1 =:= 2; 1 =:= 1 ->
       works
  end,
  if 1 =:= 2, 1 =:= 1 ->
       fails
  end.

help_me(Animal) ->
  Talk = if Animal == cat -> "meow";
            Animal == beef -> "mooo";
            Animal == dog -> "bark";
            Animal == tree -> "bark";
            true -> "fgdjkl;a"
         end,
  {Animal, "says " ++ Talk ++ "!"}.
