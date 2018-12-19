# churchsite
Website for Dark Acre Church indexing Twitch broadcast archives.
Overview: A website for indexing and archiving activity from the Twitch channel. Must be clean, readable, accessible, *simple*. Must be mobile-friendly.

Main page: Title, relevant socials links (Twitch page, Twitter, Backloggery, Steam), most recent archives, search bar. Indicator for if currently live on Twitch

Episode page: Episode number and title with date of live broadcast and link to YouTube archive.

Section for each game seen (space for 6-12). Should include: Game Title, link to purchase page with PC/Steam prioritised, Steam metadata if available - price, rating, screenshots? OpenCritic and MetaCritic (primary and user) scores, Jack decision (Owned, Wishlist, Followed, Ignored, allow multiple of these to be chosen). Link to YouTube archive (if available) starting at timestamp of actual appearance during broadcast, video opens in a pop-up?

Disallow commenting.

Data updates and load to website modules performed from a Google Sheets spreadsheet. Current archive sheet contains fields for Episode #, Title, Date of Broadcast, Content title, Content Steam URL, Jack decision, and YouTube time-stamp.

Some quantification functions: total number of games reviewed, total numbers for different Jack decisions.

Rewards page: secondary page that shows the current games available for Patience Credit redemptions, along with each game's relevant store page metadata (price, summary, screenshots?, trailer?), link to store page. Includes a section for redemption instructions and also explanation of how Patience Credits are earned. Also if a given reward has been seen in Church, and the video is available, a link to that on-site.

Stretch goal to above: ability to redeem a "Patience Credits" game from the site and send an alert via Streamlabs to a live broadcast.
