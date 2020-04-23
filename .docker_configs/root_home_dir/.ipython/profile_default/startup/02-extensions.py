# %load_ext sql - https://github.com/catherinedevlin/ipython-sql
# connect - %sql sqlite://
# %sql SELECT * FROM ...
get_ipython().magic("load_ext sql")

# use %%notify to get a browser notification upon completion of a cell
get_ipython().magic("load_ext jupyternotify")

# in the nb:
# %autoreload 0 - disables the auto-reloading. This is the default setting.
# %autoreload 1 - only auto-reload modules that were imported using the %aimport function (e.g %aimport my_module)
# %autoreload 2 - auto-reload all the modules.
get_ipython().magic("load_ext autoreload")