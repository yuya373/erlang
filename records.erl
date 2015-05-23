-module(records).
-compile(export_all).
-record(robot, {name,
               type=industrial,
               hobbies,
               details=[]}).

first_robot() ->
  #robot{name="Mechatron",
        type=handmade,
        details=["Moved by a small man inside"]}.

car_factory(CorpName) ->
  #robot{name = CorpName, hobbies = "building cars"}.

-record(user, {id, name, group, age}).

admin_panel(#user{name=Name, group=admin}) ->
  Name ++ " is allowed!";
admin_panel(#user{name=Name}) ->
  Name ++ " is not allowed!".

adult_section(U = #user{}) when U#user.age >= 18 ->
  allowd;
adult_section(_) ->
  forbidden.

repairman(Rob) ->
  Details = Rob#robot.details,
  NewRob = Rob#robot{details = ["Repaired by repairman" | Details]},
  {repaired, NewRob}.

-include("records.hrl").

included() -> #included{some_field = "Some Value"}.
