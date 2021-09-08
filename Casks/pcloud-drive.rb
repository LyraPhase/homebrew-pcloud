#
# Cask:: pcloud-drive
# Recipe:: default
# Authors:: James Cuzella, Tom Gross
#
# Copyright:: © 🄯 2019-2020,  James Cuzella
# Copyright:: © 🄯 2019 Tom Gross
# License:: GPLv3.0
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.


cask "pcloud-drive" do
  version "3.10.5"

  if Hardware::CPU.intel?
    sha256 "e95c5778a7ec7ce88a09d6a44d44cfcfbe8fda68e2a1295bfe4187bb668b07cf"
    pkg "pCloud Drive #{version.to_s}.pkg"

    code = "XZMs0dXZ5AdF7HzjFESTjxVdoWXl4LDwivFk"
  else
    sha256 "e95c5778a7ec7ce88a09d6a44d44cfcfbe8fda68e2a1295bfe4187bb668b07cf"
    pkg "pCloud Drive #{version.to_s} M1.pkg"

    code = "XZvs0dXZEFARsDjjTNmBgnGmY8R8lzhjh7Qk"
  end

  url do
    require "net/http"
    require "json"
    api = "https://api.pcloud.com/"
    uri = URI(api + "getpublinkdownload?code=" + code)
    response = Net::HTTP.get(uri)
    data = JSON.parse(response)
    "https://" + data["hosts"][0] + data["path"]
  end

  livecheck do
    url "https://www.pcloud.com/release-notes/mac-os.html"
    strategy :page_match
    regex(%r{<b>(\d+(?:\.\d+)*)</b>}i)
  end

  name "pCloud Drive"
  homepage "https://www.pcloud.com/"
  desc "Client for the pCloud virtual cloud storage service"

  depends_on cask: "macfuse"

  uninstall quit:    "com.pcloud.pcloud.macos",
            pkgutil: "com.mobileinno.pkg.pCloudDrive"
end
