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
    public interface HostConnectorBusIFace : Object {
        public abstract bool open (string[] urls) throws DBusError, IOError;

    }

    public class Helper : Application {
        private HostConnectorBusIFace? host_connector;

        public Helper () {
            Object (
                application_id: "com.paysonwallach.amber.helper",
                flags : ApplicationFlags.HANDLES_OPEN);
        }

        public override void open (File[] files, string hint) {
            var i = 0;
            var uris = new string[files.length];
            foreach (File file in files) {
                uris[i++] = file.get_uri ();
            }

            try {
                host_connector = Bus.get_proxy_sync (
                    BusType.SESSION,
                    "com.paysonwallach.amber.bridge",
                    "/com/paysonwallach/amber/bridge");
                host_connector.open (uris);
            } catch (DBusError err) {
                warning (@"DBusError: $(err.message)");
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
