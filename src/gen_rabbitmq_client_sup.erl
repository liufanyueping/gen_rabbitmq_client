-module(gen_rabbitmq_client_sup).
-author('LiuFan <liufanyansha@sina.cn>').
-behaviour(supervisor).

%% API
-export([start_link/0]).

%% Supervisor callbacks
-export([init/1]).

%% Helper macro for declaring children of supervisor
-define(CHILD(I, Type), {I, {I, start_link, []}, permanent, 5000, Type, [I]}).

%% ===================================================================
%% API functions
%% ===================================================================

start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

%% ===================================================================
%% Supervisor callbacks
%% ===================================================================

init([]) ->
	Children = ?CHILD(gen_rabbitmq_connection_mon, worker),
    {ok, { {one_for_one, 5, 10}, [Children]} }.

