class SingleCountryRepo {
  String? abbreviation;
  String? clientIp;
  String? datetime;
  int? dayOfWeek;
  int? dayOfYear;
  bool? dst;
  Null? dstFrom;
  int? dstOffset;
  Null? dstUntil;
  int? rawOffset;
  String? timezone;
  int? unixtime;
  String? utcDatetime;
  String? utcOffset;
  int? weekNumber;

  SingleCountryRepo(
      {this.abbreviation,
      this.clientIp,
      this.datetime,
      this.dayOfWeek,
      this.dayOfYear,
      this.dst,
      this.dstFrom,
      this.dstOffset,
      this.dstUntil,
      this.rawOffset,
      this.timezone,
      this.unixtime,
      this.utcDatetime,
      this.utcOffset,
      this.weekNumber});

  SingleCountryRepo.fromJson(Map<String, dynamic> json) {
    abbreviation = json['abbreviation'];
    clientIp = json['client_ip'];
    datetime = json['datetime'];
    dayOfWeek = json['day_of_week'];
    dayOfYear = json['day_of_year'];
    dst = json['dst'];
    dstFrom = json['dst_from'];
    dstOffset = json['dst_offset'];
    dstUntil = json['dst_until'];
    rawOffset = json['raw_offset'];
    timezone = json['timezone'];
    unixtime = json['unixtime'];
    utcDatetime = json['utc_datetime'];
    utcOffset = json['utc_offset'];
    weekNumber = json['week_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['abbreviation'] = abbreviation;
    data['client_ip'] = clientIp;
    data['datetime'] = datetime;
    data['day_of_week'] = dayOfWeek;
    data['day_of_year'] = dayOfYear;
    data['dst'] = dst;
    data['dst_from'] = dstFrom;
    data['dst_offset'] = dstOffset;
    data['dst_until'] = dstUntil;
    data['raw_offset'] = rawOffset;
    data['timezone'] = timezone;
    data['unixtime'] = unixtime;
    data['utc_datetime'] = utcDatetime;
    data['utc_offset'] = utcOffset;
    data['week_number'] = weekNumber;
    return data;
  }
}
