/*
TAPO Apartments API

API for TAPO Apartments website

API version: 1.0.0
*/

// Code generated by OpenAPI Generator (https://openapi-generator.tech); DO NOT EDIT.

package openapi

import (
	"encoding/json"
	"time"
	"bytes"
	"fmt"
)

// checks if the ExternalAvailabilityResponse type satisfies the MappedNullable interface at compile time
var _ MappedNullable = &ExternalAvailabilityResponse{}

// ExternalAvailabilityResponse struct for ExternalAvailabilityResponse
type ExternalAvailabilityResponse struct {
	// Apartment slug
	Slug string `json:"slug"`
	// List of unavailable date ranges from external source
	UnavailableDates []UnavailableDateRange `json:"unavailableDates"`
	// Time of last successful sync
	LastSyncedAt time.Time `json:"lastSyncedAt"`
	// Source of the external data
	Source string `json:"source"`
}

type _ExternalAvailabilityResponse ExternalAvailabilityResponse

// NewExternalAvailabilityResponse instantiates a new ExternalAvailabilityResponse object
// This constructor will assign default values to properties that have it defined,
// and makes sure properties required by API are set, but the set of arguments
// will change when the set of required properties is changed
func NewExternalAvailabilityResponse(slug string, unavailableDates []UnavailableDateRange, lastSyncedAt time.Time, source string) *ExternalAvailabilityResponse {
	this := ExternalAvailabilityResponse{}
	this.Slug = slug
	this.UnavailableDates = unavailableDates
	this.LastSyncedAt = lastSyncedAt
	this.Source = source
	return &this
}

// NewExternalAvailabilityResponseWithDefaults instantiates a new ExternalAvailabilityResponse object
// This constructor will only assign default values to properties that have it defined,
// but it doesn't guarantee that properties required by API are set
func NewExternalAvailabilityResponseWithDefaults() *ExternalAvailabilityResponse {
	this := ExternalAvailabilityResponse{}
	return &this
}

// GetSlug returns the Slug field value
func (o *ExternalAvailabilityResponse) GetSlug() string {
	if o == nil {
		var ret string
		return ret
	}

	return o.Slug
}

// GetSlugOk returns a tuple with the Slug field value
// and a boolean to check if the value has been set.
func (o *ExternalAvailabilityResponse) GetSlugOk() (*string, bool) {
	if o == nil {
		return nil, false
	}
	return &o.Slug, true
}

// SetSlug sets field value
func (o *ExternalAvailabilityResponse) SetSlug(v string) {
	o.Slug = v
}

// GetUnavailableDates returns the UnavailableDates field value
func (o *ExternalAvailabilityResponse) GetUnavailableDates() []UnavailableDateRange {
	if o == nil {
		var ret []UnavailableDateRange
		return ret
	}

	return o.UnavailableDates
}

// GetUnavailableDatesOk returns a tuple with the UnavailableDates field value
// and a boolean to check if the value has been set.
func (o *ExternalAvailabilityResponse) GetUnavailableDatesOk() ([]UnavailableDateRange, bool) {
	if o == nil {
		return nil, false
	}
	return o.UnavailableDates, true
}

// SetUnavailableDates sets field value
func (o *ExternalAvailabilityResponse) SetUnavailableDates(v []UnavailableDateRange) {
	o.UnavailableDates = v
}

// GetLastSyncedAt returns the LastSyncedAt field value
func (o *ExternalAvailabilityResponse) GetLastSyncedAt() time.Time {
	if o == nil {
		var ret time.Time
		return ret
	}

	return o.LastSyncedAt
}

// GetLastSyncedAtOk returns a tuple with the LastSyncedAt field value
// and a boolean to check if the value has been set.
func (o *ExternalAvailabilityResponse) GetLastSyncedAtOk() (*time.Time, bool) {
	if o == nil {
		return nil, false
	}
	return &o.LastSyncedAt, true
}

// SetLastSyncedAt sets field value
func (o *ExternalAvailabilityResponse) SetLastSyncedAt(v time.Time) {
	o.LastSyncedAt = v
}

// GetSource returns the Source field value
func (o *ExternalAvailabilityResponse) GetSource() string {
	if o == nil {
		var ret string
		return ret
	}

	return o.Source
}

// GetSourceOk returns a tuple with the Source field value
// and a boolean to check if the value has been set.
func (o *ExternalAvailabilityResponse) GetSourceOk() (*string, bool) {
	if o == nil {
		return nil, false
	}
	return &o.Source, true
}

// SetSource sets field value
func (o *ExternalAvailabilityResponse) SetSource(v string) {
	o.Source = v
}

func (o ExternalAvailabilityResponse) MarshalJSON() ([]byte, error) {
	toSerialize,err := o.ToMap()
	if err != nil {
		return []byte{}, err
	}
	return json.Marshal(toSerialize)
}

func (o ExternalAvailabilityResponse) ToMap() (map[string]interface{}, error) {
	toSerialize := map[string]interface{}{}
	toSerialize["slug"] = o.Slug
	toSerialize["unavailableDates"] = o.UnavailableDates
	toSerialize["lastSyncedAt"] = o.LastSyncedAt
	toSerialize["source"] = o.Source
	return toSerialize, nil
}

func (o *ExternalAvailabilityResponse) UnmarshalJSON(data []byte) (err error) {
	// This validates that all required properties are included in the JSON object
	// by unmarshalling the object into a generic map with string keys and checking
	// that every required field exists as a key in the generic map.
	requiredProperties := []string{
		"slug",
		"unavailableDates",
		"lastSyncedAt",
		"source",
	}

	allProperties := make(map[string]interface{})

	err = json.Unmarshal(data, &allProperties)

	if err != nil {
		return err;
	}

	for _, requiredProperty := range(requiredProperties) {
		if _, exists := allProperties[requiredProperty]; !exists {
			return fmt.Errorf("no value given for required property %v", requiredProperty)
		}
	}

	varExternalAvailabilityResponse := _ExternalAvailabilityResponse{}

	decoder := json.NewDecoder(bytes.NewReader(data))
	decoder.DisallowUnknownFields()
	err = decoder.Decode(&varExternalAvailabilityResponse)

	if err != nil {
		return err
	}

	*o = ExternalAvailabilityResponse(varExternalAvailabilityResponse)

	return err
}

type NullableExternalAvailabilityResponse struct {
	value *ExternalAvailabilityResponse
	isSet bool
}

func (v NullableExternalAvailabilityResponse) Get() *ExternalAvailabilityResponse {
	return v.value
}

func (v *NullableExternalAvailabilityResponse) Set(val *ExternalAvailabilityResponse) {
	v.value = val
	v.isSet = true
}

func (v NullableExternalAvailabilityResponse) IsSet() bool {
	return v.isSet
}

func (v *NullableExternalAvailabilityResponse) Unset() {
	v.value = nil
	v.isSet = false
}

func NewNullableExternalAvailabilityResponse(val *ExternalAvailabilityResponse) *NullableExternalAvailabilityResponse {
	return &NullableExternalAvailabilityResponse{value: val, isSet: true}
}

func (v NullableExternalAvailabilityResponse) MarshalJSON() ([]byte, error) {
	return json.Marshal(v.value)
}

func (v *NullableExternalAvailabilityResponse) UnmarshalJSON(src []byte) error {
	v.isSet = true
	return json.Unmarshal(src, &v.value)
}


