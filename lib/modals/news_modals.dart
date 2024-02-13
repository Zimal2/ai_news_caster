class NewsModals {
    String status;
    String copyright;
    Response response;

    NewsModals({
        required this.status,
        required this.copyright,
        required this.response,
    });

}

class Response {
    List<Doc> docs;
    Meta meta;

    Response({
        required this.docs,
        required this.meta,
    });

}

class Doc {
    String docAbstract;
    String webUrl;
    String snippet;
    String leadParagraph;
    String? printSection;
    String? printPage;
    Source source;
    List<Multimedia> multimedia;
    Headline headline;
    List<Keyword> keywords;
    String pubDate;
    DocumentType documentType;
    NewsDesk newsDesk;
    SectionName sectionName;
    SubsectionName subsectionName;
    Byline byline;
    TypeOfMaterial typeOfMaterial;
    String id;
    int wordCount;
    String uri;

    Doc({
        required this.docAbstract,
        required this.webUrl,
        required this.snippet,
        required this.leadParagraph,
        this.printSection,
        this.printPage,
        required this.source,
        required this.multimedia,
        required this.headline,
        required this.keywords,
        required this.pubDate,
        required this.documentType,
        required this.newsDesk,
        required this.sectionName,
        required this.subsectionName,
        required this.byline,
        required this.typeOfMaterial,
        required this.id,
        required this.wordCount,
        required this.uri,
    });

}

class Byline {
    String original;
    List<Person> person;
    dynamic organization;

    Byline({
        required this.original,
        required this.person,
        required this.organization,
    });

}

class Person {
    String firstname;
    String? middlename;
    String lastname;
    dynamic qualifier;
    dynamic title;
    Role role;
    String organization;
    int rank;

    Person({
        required this.firstname,
        required this.middlename,
        required this.lastname,
        required this.qualifier,
        required this.title,
        required this.role,
        required this.organization,
        required this.rank,
    });

}

enum Role {
    REPORTED
}

enum DocumentType {
    ARTICLE
}

class Headline {
    String main;
    String? kicker;
    dynamic contentKicker;
    String? printHeadline;
    dynamic name;
    dynamic seo;
    dynamic sub;

    Headline({
        required this.main,
        required this.kicker,
        required this.contentKicker,
        required this.printHeadline,
        required this.name,
        required this.seo,
        required this.sub,
    });

}

class Keyword {
    Name name;
    String value;
    int rank;
    Major major;

    Keyword({
        required this.name,
        required this.value,
        required this.rank,
        required this.major,
    });

}

enum Major {
    N
}

enum Name {
    GLOCATIONS,
    ORGANIZATIONS,
    PERSONS,
    SUBJECT
}

class Multimedia {
    int rank;
    String subtype;
    dynamic caption;
    dynamic credit;
    Type type;
    String url;
    int height;
    int width;
    Legacy legacy;
    String subType;
    String cropName;

    Multimedia({
        required this.rank,
        required this.subtype,
        required this.caption,
        required this.credit,
        required this.type,
        required this.url,
        required this.height,
        required this.width,
        required this.legacy,
        required this.subType,
        required this.cropName,
    });

}

class Legacy {
    String? xlarge;
    int? xlargewidth;
    int? xlargeheight;
    String? thumbnail;
    int? thumbnailwidth;
    int? thumbnailheight;
    int? widewidth;
    int? wideheight;
    String? wide;

    Legacy({
        this.xlarge,
        this.xlargewidth,
        this.xlargeheight,
        this.thumbnail,
        this.thumbnailwidth,
        this.thumbnailheight,
        this.widewidth,
        this.wideheight,
        this.wide,
    });

}

enum Type {
    IMAGE
}

enum NewsDesk {
    PODCASTS,
    POLITICS
}

enum SectionName {
    PODCASTS,
    U_S
}

enum Source {
    THE_NEW_YORK_TIMES
}

enum SubsectionName {
    POLITICS,
    THE_DAILY
}

enum TypeOfMaterial {
    NEWS
}

class Meta {
    int hits;
    int offset;
    int time;

    Meta({
        required this.hits,
        required this.offset,
        required this.time,
    });

}
