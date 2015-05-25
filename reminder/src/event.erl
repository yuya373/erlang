-module(event).
-compile(export_all).
-record(state, {
          server,
          name = "",
          to_go = 0
         }).

loop(S = #state{server=Server, to_go=[H|T]}) ->
  receive
    {Server, Ref, cancel} ->
      Server ! {Ref, ok}
  after H * 1000 ->
          if
            T =:= [] ->
              Server ! {done, S#state.name};
            T =/= [] ->
              loop(S#state{to_go = T})
          end
  end.

normarize(N) ->
  Limit = 49 * 24 * 60 * 60,
  [N rem Limit | lists:duplicate(N div Limit, Limit)].

start(EventName, DateTime) ->
  spawn(?MODULE, init, [self(), EventName, DateTime]).

start_link(EventName, DateTime) ->
  spawn_link(?MODULE, init, [self(), EventName, DateTime]).

init(Server, EventName, DateTime) ->
  loop(#state{
          server = Server,
          name = EventName,
          to_go = time_to_go(DateTime)
         }).

cancel(Pid) ->
  Ref = erlang:monitor(process, Pid),
  Pid ! {self(), Ref, cancel},
  receive
    {Ref, ok} ->
      erlang:demonitor(Ref, [flush]),
      ok;
    {'DOWN', Ref, process, Pid, _Reason} ->
      ok
  end.

time_to_go(TimeOut = {{_,_,_}, {_,_,_}}) ->
  Now = calendar:local_time(),
  ToGo = calendar:datetime_to_gregorian_seconds(TimeOut) - calendar:datetime_to_gregorian_seconds(Now),
  Secs = if
           ToGo > 0 -> ToGo;
           ToGo =< 0 -> 0
         end,
  normarize(Secs).
