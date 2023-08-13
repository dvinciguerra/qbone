# frozen_string_literal: true

require "spec_helper"

class DummyJob
  include Qbone::Job

  qbone_options queue: "dummy", retries: 3
end

RSpec.describe Qbone::Job do
  describe ".qbone_options" do
    it { expect(DummyJob).to respond_to(:qbone_options) }
    it { expect(DummyJob.queue).to eq("dummy_queue") }

    context "with defined retries" do
      it { expect(DummyJob.retries).to eq(3) }
    end

    context "with defined dead_letter" do
      it { expect(DummyJob.dead_letter).to eq("dummy_dead_queue") }
    end
  end
end
