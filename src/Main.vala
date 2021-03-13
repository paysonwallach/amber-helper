/*
 * Copyright (c) 2020 Payson Wallach
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */

namespace Amber {
    [DBus (name = "com.paysonwallach.amber.bridge")]
    public interface BrowserProxyBusIFace : Object {
        public abstract bool open (string[] urls) throws DBusError, IOError;

    }

    public class Helper : Application {
        private uint watch_id = 0U;

        public Helper () {
            Object (
                application_id: Config.APP_ID,
                flags: ApplicationFlags.HANDLES_OPEN);
        }

        private void request_proxy_open (string[] uris) throws DBusError, IOError {
            BrowserProxyBusIFace? browser_proxy = Bus.get_proxy_sync (
                BusType.SESSION,
                Config.BRIDGE_DBUS_SERVICE_NAME,
                Config.BRIDGE_DBUS_OBJECT_PATH);

            browser_proxy.open (uris);
            release ();
        }

        private void request_browser_launch (string[] uris) {
            var app_info = AppInfo.get_default_for_type ("text/html", false);
            if (app_info == null)
                return;

            try {
                app_info.launch_uris (null, null);
                watch_id = Bus.watch_name (
                    BusType.SESSION,
                    Config.BRIDGE_DBUS_SERVICE_NAME, BusNameWatcherFlags.NONE,
                    () => on_name_acquired (uris));
            } catch (Error err) {
                warning (@"unable to get default type: $(err.message)");
            }
        }

        private void on_name_acquired (string[] uris) {
            try {
                request_proxy_open (uris);
            } catch (DBusError err) {
                warning (@"DBusError: $(err.message)");
            } catch (IOError err) {
                warning (@"IOError: $(err.message)");
            }

            if (watch_id != 0U)
                Bus.unwatch_name (watch_id);
        }

        public override void open (File[] files, string hint) {
            hold ();

            var uris = new string[files.length];
            for (var i = 0 ; i < files.length ; i++)
                uris[i] = files[i].get_uri ();

            try {
                request_proxy_open (uris);
            } catch (DBusError err) {
                if (err.code == DBusError.SERVICE_UNKNOWN) {
                    request_browser_launch (uris);
                } else {
                    warning (@"DBusError: $(err.message)");
                }
            } catch (IOError err) {
                warning (@"IOError: $(err.message)");
            }
        }

    }

    public static int main (string[] args) {
        var app = new Helper ();
        return app.run (args);
    }

}
