package com.o.bean;

import java.util.List;

import org.bson.types.ObjectId;
import org.springframework.data.document.mongodb.mapping.Document;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

@Document
public class Article {

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getAbstract() {
		return _abstract;
	}

	public void setAbstract(String abstact) {
		this._abstract = abstact;
	}

	public List<String> getKeyWords() {
		return keyWords;
	}

	public void setKeyWords(List<String> keyWords) {
		this.keyWords = keyWords;
	}

	public String getVersion() {
		return version;
	}

	public void setVersion(String version) {
		this.version = version;
	}

	public ObjectId getId() {
		return _id;
	}

	public void setId(ObjectId id) {
		this._id = id;
	}

	public List<String> getText() {
		return text;
	}

	public void setText(List<String> text) {
		this.text = text;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getSub_tag() {
		return sub_tag;
	}

	public void setSub_tag(String sub_tag) {
		this.sub_tag = sub_tag;
	}

	public String getTag() {
		return tag;
	}

	public void setTag(String tag) {
		this.tag = tag;
	}

	public Long getCreate_time() {
		return create_time;
	}

	public void setCreate_time(Long create_time) {
		this.create_time = create_time;
	}

	@Expose
	String title;

	@Expose
	@SerializedName("abstract")
	String _abstract;
	@Expose
	List<String> keyWords;
	@Expose
	String version;

	ObjectId _id;
	@Expose
	List<String> text;
	@Expose
	String url;
	@Expose
	String sub_tag;
	@Expose
	String tag;
	@Expose
	Long create_time;

	@Override
	public String toString() {
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.append("article[");
		stringBuilder.append("id=");
		stringBuilder.append(this._id);
		stringBuilder.append(", ");
		// stringBuilder.append(System.getProperty("line.separator", "\n"));

		stringBuilder.append("title=");
		stringBuilder.append(this.title.trim());
		stringBuilder.append(", ");
		// stringBuilder.append(System.getProperty("line.separator", "\n"));

		stringBuilder.append("abstract=");
		stringBuilder.append(this._abstract.trim());
		stringBuilder.append(", ");
		// stringBuilder.append(System.getProperty("line.separator", "\n"));

		stringBuilder.append("keywords=[");
		if (this.getKeyWords() != null) {
			for (String string : this.getKeyWords()) {
				stringBuilder.append(string);
				stringBuilder.append(", ");
			}
		}

		stringBuilder.append("]");
		stringBuilder.append(", ");

		stringBuilder.append(this._abstract.trim());
		// stringBuilder.append(System.getProperty("line.separator", "\n"));

		stringBuilder.append("]");

		return stringBuilder.toString();
	}
}
