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
  if Hardware::CPU.intel?
    version "3.11.4"
  elsif Hardware::CPU.physical_cpu_arm64?
    version "3.11.4"
  end

  if Hardware::CPU.intel?
    sha256 "772581869c2cece613cc16ea954a5cd2275a1b4a5d2aa95d876480bd5436bbf3"

    pkg "pCloud Drive #{version.to_s}.pkg"

    code = "XZkiyVVZbNzHvVkMPiyUdW7EjPyLguoyu0QV"
  else
    sha256 "9338ca82340a2e421c144f926bfd99d9598b3df104d0737918d89c5b28898d02"

    pkg "pCloud Drive #{version.to_s} M1.pkg"

    code = "XZHiyVVZY6pQSWzTKUVdpTon2mDqGh4PhUyk"
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
